//
//  SFOutputStreamViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/6.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 通过输出流实现将请求到的数据写入沙盒文件中实现文件下载
 */

import UIKit

fileprivate let fullPath = cachePath + "/demo.mp4"

class SFOutputStreamViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var outputStream: OutputStream?
    
    var task: URLSessionDataTask?
    var currentSize: Float = 0
    var totalSize: Float = 0
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 断点续传（离线下载）：获取上次下载文件的断点
        let attribteds = try? FileManager.default.attributesOfItem(atPath: fullPath)
        if let currentSize = attribteds?[FileAttributeKey.size] as? Float {
            self.currentSize = currentSize
        }

        // 离线下载重新进入下载页面，恢复之前的下载进度
        let totalSize = UserDefaults.standard.float(forKey: "totalSize")
        self.progressView.progress = currentSize/totalSize
        self.progressLabel.text = "\(self.progressView.progress)"
    }
    
    @IBAction func startDownload(_ sender: UIButton) {
        statusLabel.text = "下载中..."
        startDownload()
    }
    @IBAction func pauseDownload(_ sender: UIButton) {
        task?.suspend()
        statusLabel.text = "已暂停"
    }
    @IBAction func resumePauseDownload(_ sender: UIButton) {
        task?.resume()
        statusLabel.text = "继续下载中..."
    }
    @IBAction func cancelDownload(_ sender: UIButton) {
        task?.cancel()
        statusLabel.text = "已取消"
    }
    @IBAction func resumeCancelDownload(_ sender: UIButton) {
        startDownload()
        statusLabel.text = "继续下载中..."
    }
}

//MARK: - Lift Cycle
extension SFOutputStreamViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        /*
         创建的session的delegate是当前控制器，session对当前控制器有强引用。当前控制器在退出后不会自动释放。必须通过以下两个方法之一实现对当前控制器的释放
         */
        // 任务下载完成后释放当前vc
        self.session.finishTasksAndInvalidate()
        // or
        // 立即结束任务释放当前vc
        self.session.invalidateAndCancel()
    }
}

//MARK: - 开始下载
extension SFOutputStreamViewController {
    func startDownload() {
        let url = URL(string: "resources/videos/minion_01.mp4", relativeTo: baseURL)
        var request = URLRequest(url: url!)
        request.setValue("bytes=\(Int64(self.currentSize))-", forHTTPHeaderField: "Range")
        let task = session.dataTask(with: request)
        self.task = task
        task.resume()
    }
}

//MARK: - URLSessionDataDelegate
extension SFOutputStreamViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        // 获取数据下载总大小
        self.totalSize = Float(response.expectedContentLength) + self.currentSize
        
        // 保存数据总大小，当APP意外退出后，重新进入下载页面，根据视频总大小
        UserDefaults.standard.set(totalSize, forKey: "totalSize")

        /*
         1. filePath:写入文件的位置
         2. append:
            True:如果有数据，拼接到原有数据尾部
            False:如果没有数据，创建一个新的空数据
         */
        let outputStream = OutputStream(toFileAtPath: fullPath, append: true)
        
        // 打开输出流
        outputStream?.open()
        self.outputStream = outputStream
        
        // 通知系统允许接收数据
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        // 接收到服务器返回的数据时，通过输出流往沙盒中写数据
        data.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Void in
            self.outputStream?.write(bytes, maxLength: data.count)
        }
        
        // 设置显示进度
        self.currentSize += Float(data.count)
        self.progressView.progress = currentSize/totalSize
        self.progressLabel.text = "\(self.progressView.progress)"
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        // 关闭输出流
        self.outputStream?.close()
        
        if error == nil {
            statusLabel.text = "下载成功"
            self.currentSize = 0
        } else {
            statusLabel.text = "下载失败"
            print("currentSize = ", currentSize)
        }
    }
}
