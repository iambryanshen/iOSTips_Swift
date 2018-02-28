//
//  SFClosureViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/6.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFClosureViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var session: URLSession = {
        let session: URLSession = URLSession.shared
        return session
    }()
    
    lazy var downloadTask: URLSessionDownloadTask = {
        let url = URL(string: "http://img4q.duitang.com/uploads/item/201406/09/20140609150919_ZztLd.jpeg")!
        let downloadTask: URLSessionDownloadTask = session.downloadTask(with: url, completionHandler: { (location, response, error) in
            OperationQueue.main.addOperation {
                if error != nil {
                    print("下载失败 error = \(String(describing: error))")
                } else {
                    self.statusLabel.text = "网络请求成功"
                }
                // 获取保存数据的路径：Library/caches/suggestedFilename
                let fullPath = cachePath + "/" + (response?.suggestedFilename ?? "")
                // 根据该路径创建保存数据的url，必须通过fileURLWithPath的方式创建，该方式创建的url前面有file://
                let url = URL(fileURLWithPath: fullPath)
                // 数据成功
                do {
                    try FileManager.default.moveItem(at: location!, to: url)
                    self.statusLabel.text = "下载成功"
                    self.imageView.image = UIImage(contentsOfFile: fullPath)
                } catch let errorMsg {
                    self.statusLabel.text = "数据写入失败"
                    print("移动文件到指定存储目录失败，error = \(errorMsg)")
                    self.imageView.image = UIImage(contentsOfFile: fullPath)
                }
            }
        })
        return downloadTask
    }()
    
    @IBAction func startDownload(_ sender: UIButton) {
        downloadTask.resume()
        statusLabel.text = "下载中..."
    }
    @IBAction func pauseDownload(_ sender: UIButton) {
        downloadTask.suspend()
        statusLabel.text = "已暂停下载"
    }
    @IBAction func resumeDownload(_ sender: UIButton) {
        downloadTask.resume()
        statusLabel.text = "继续下载中..."
    }
    @IBAction func cancelDownload(_ sender: UIButton) {
        downloadTask.cancel()
        statusLabel.text = "已取消下载"
    }
}
