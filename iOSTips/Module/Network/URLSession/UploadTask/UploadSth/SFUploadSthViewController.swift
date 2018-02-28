//
//  SFUploadSthViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/2.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

let line: String = "----WebKitFormBoundaryWn7cGV6RiPpTDuuY"
let newLine: Data = "\r\n".data(using: String.Encoding.utf8)!

class SFUploadSthViewController: UIViewController {
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    lazy var uploadTask: URLSessionUploadTask = {
        let url = URL(string: "http://120.25.226.186:32812/upload")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(line)", forHTTPHeaderField: "Content-Type")
        let bodydata = bodyData()
        let uploadTask: URLSessionUploadTask = session.uploadTask(with: request, from: bodydata, completionHandler: { (data, response, error) in
            if error == nil, let data = data {
                print(String(data: data, encoding: String.Encoding.utf8) ?? "")
            }
        })
        return uploadTask
    }()
    
    // 设置请求体数据
    /*
     ------WebKitFormBoundaryWn7cGV6RiPpTDuuY
     Content-Disposition: form-data; name="file"; filename=""
     Content-Type: application/octet-stream
     
     // 该行为上传的数据，浏览器默认隐藏
     ------WebKitFormBoundaryWn7cGV6RiPpTDuuY
     Content-Disposition: form-data; name="username"
     
     brian
     ------WebKitFormBoundaryWn7cGV6RiPpTDuuY--
     */
    func bodyData() -> Data {
        var data = Data()
        data.append("--\(line)".data(using: .utf8)!)
        data.append(newLine)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"icon.JPG\"".data(using: String.Encoding.utf8)!)
        data.append(newLine)
        data.append("Content-Type: image/jpg".data(using: String.Encoding.utf8)!)
        data.append(newLine)
        data.append(newLine)
        var imageData = Data()
        if let image = UIImage(named: "icon.JPG") {
            if let tempImage = UIImageJPEGRepresentation(image, 1) {
                imageData = tempImage
            } else {
                print("图片压缩失败")
            }
        } else {
            print("图片读取失败")
        }
        data.append(imageData)
        data.append(newLine)
        data.append("--\(line)".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"username\"".data(using: String.Encoding.utf8)!)
        data.append(newLine)
        data.append(newLine)
        data.append("brian".data(using: String.Encoding.utf8)!)
        data.append(newLine)
        data.append("--\(line)--".data(using: String.Encoding.utf8)!)
        // 上传文件参数
        return data
    }

    // 上传图片
    @IBAction func uploadImage(_ sender: UIButton) {
        uploadTask.resume()
    }
}

extension SFUploadSthViewController: URLSessionDataDelegate {

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Float(totalBytesSent)/Float(totalBytesExpectedToSend)
        print(progress)
    }
}
