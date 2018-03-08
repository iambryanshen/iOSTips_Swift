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
        // 创建下载URL
        let url = URL(string: "http://img4q.duitang.com/uploads/item/201406/09/20140609150919_ZztLd.jpeg")!
        // 创建下载任务
        let downloadTask: URLSessionDownloadTask = session.downloadTask(with: url, completionHandler: { (location, response, error) in
            
            if error != nil {
                print("下载失败 error = \(String(describing: error))")
                return
            } else {
                self.statusLabel.text = "网络请求成功"
            }
            
            // 获取保存数据的路径：Library/caches/suggestedFilename
            let fullPath = cachePath + "/" + (response?.suggestedFilename ?? "")
            // 根据该路径创建保存数据的url，必须通过fileURLWithPath的方式创建，该方式创建的url前面有file://
            let dstURL = URL(fileURLWithPath: fullPath)
            
            // 主线程更新UI
            OperationQueue.main.addOperation {
                do {
                    // 将下载的数据由临时目录移动到目标存储目录
                    try FileManager.default.moveItem(at: location!, to: dstURL)
                    
                    // 更新下载状态，显示下载数据
                    self.statusLabel.text = "下载成功"
                    self.imageView.image = UIImage(contentsOfFile: fullPath)
                } catch let errorMsg {
                    print("移动临时文件到指定存储目录失败，error = \(errorMsg)")
                    // 更新下载状态，显示下载数据
                    self.statusLabel.text = "移动临时文件到指定存储目录失败"
                    self.imageView.image = nil
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
