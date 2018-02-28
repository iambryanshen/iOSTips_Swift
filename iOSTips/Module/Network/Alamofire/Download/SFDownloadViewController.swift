//
//  SFDownloadViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/11.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Alamofire

class SFDownloadViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBAction func download(_ sender: UIButton) {
        
        // 下载URL
//        let url = URL(string: "http://e.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513d72ad82da3f6d55fbb2fbd9ab.jpg")!
        let url = URL(string: "http://120.25.226.186:32812/resources/videos/minion_01.mp4")!
        
        // 下载请求
        let request = URLRequest(url: url)

        // 下载完成后保存的位置
        let destination : DownloadRequest.DownloadFileDestination = {_,_ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        // 下载资源
        Alamofire.download(request, to: destination).response { (response) in
            
            // 判断下载成功与失败，获取资源路径
            if response.error == nil, let path = response.destinationURL?.path {
                self.statusLabel.text = "下载成功"
                print("path = \(path)")
            } else {
                self.statusLabel.text = "下载失败"
            }
            
            // 进度计算
        }.downloadProgress { (progress) in
            self.statusLabel.text = "下载中..."
            self.progressView.progress = Float(progress.fractionCompleted)
        }
    }
}
