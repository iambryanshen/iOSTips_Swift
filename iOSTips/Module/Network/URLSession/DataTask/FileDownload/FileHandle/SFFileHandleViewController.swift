//
//  SFDownloadTaskViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/2.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 通过文件句柄FileHandle实现将下载得到的数据写入沙盒中实现文件下载
 */

import UIKit

fileprivate let fullPath = cachePath + "/demo.mp4"

class SFFileHandleViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var currentSize: Float = 0
    var totalSize: Float = 0
    var fileHandle: FileHandle?         // 文件句柄，用来往沙盒中写入下载的视频文件
    var task: URLSessionDataTask?
    
    lazy var session: URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 断点续传（离线下载）
        let attritutes = try? FileManager.default.attributesOfItem(atPath: fullPath)
        if let currentSize = attritutes?[FileAttributeKey.size] as? Float {
            self.currentSize = currentSize
        }
        
        // 如果下载过程中，App意外退出，重新打开App继续下载，恢复初始的下载进度
        let totalSize = UserDefaults.standard.float(forKey: "totalSize")
        if totalSize != 0 {
            self.progressView.progress = currentSize/totalSize
            self.progressLabel.text = "\(self.progressView.progress)"
        }
    }
    
    @IBAction func startDownload(_ sender: UIButton) {
        startDownload()
        statusLabel.text = "下载中..."
    }
    @IBAction func pauseDownload(_ sender: UIButton) {
        task?.suspend()
        statusLabel.text = "已暂停下载"
    }
    @IBAction func pauseResume(_ sender: UIButton) {
        task?.resume()
        statusLabel.text = "继续下载中..."
    }
    @IBAction func cancelDownload(_ sender: UIButton) {
        task?.cancel()
        statusLabel.text = "已取消下载"
    }
    @IBAction func cancelResume(_ sender: UIButton) {
        startDownload()
        statusLabel.text = "恢复取消，继续下载中..."
    }
}

//MARK: - Lift Cycle
extension SFFileHandleViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        /*
         创建的session的delegate是当前控制器，session对当前控制器有强引用。当前控制器在退出后不会自动释放。必须通过以下两个方法之一实现对当前控制器的释放
         */
        // 任务下载完成后释放当前vc
        self.session.finishTasksAndInvalidate()
        // or （二选一）
        // 立即结束任务释放当前vc
        self.session.invalidateAndCancel()
    }
}

/* 网络请求头：Range参数的写法
 Range =
    bytes=0-100
    bytes=-100
    bytes=400-800
    bytes=500-
 */
extension SFFileHandleViewController {
    func startDownload() {
        let url = URL(string: "resources/videos/minion_01.mp4", relativeTo: baseURL)
        var request = URLRequest(url: url!)
        let value = "bytes=\(Int64(self.currentSize))-"
        request.setValue(value, forHTTPHeaderField: "Range")
        let task: URLSessionDataTask = session.dataTask(with: request)
        self.task = task
        task.resume()
    }
}

//MARK: - URLSessionDataDelegate
extension SFFileHandleViewController: URLSessionDataDelegate {
    
    // 接收到响应时调用
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        // 1. 保存下载数据总长度（用来计算进度）
        self.totalSize = Float(response.expectedContentLength) + self.currentSize
        // 1.1. 保存视频的总大小（如果视频下载过程中，App突然退出，下次恢复下载时，保存的视频总大小用来计算初始进度）
        UserDefaults.standard.set(totalSize, forKey: "totalSize")
        
        // 2. 在保存文件的路径处创建一个空的文件，用来写下载的数据，只有第一次下载的时候需要创建空文件，恢复下载不用创建空文件
        if self.currentSize == 0 {
            FileManager.default.createFile(atPath: fullPath, contents: nil, attributes: nil)
        }
        
        // 3. 创建文件句柄并指向空文件
        fileHandle = FileHandle(forWritingAtPath: fullPath)
        // 3.1. 第二次下载（断点续传）需要移动文件句柄指针到文件末尾，如果是第一次，文件为空，移动不影响结果
        fileHandle?.seekToEndOfFile()
        
        // 通知系统允许接收数据
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    // 接收到数据时调用，可能调用多次
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        // 接收到数据，通过文件句柄写入本地
        fileHandle?.write(data)
        
        // 计算进度
        // 方法一：
        // 思路：通过文件管理类直接获取已下载的数据的大小，计算进度
//        do {
//            let attributes = try FileManager.default.attributesOfItem(atPath: fullPath ?? "")
//            let fileSize = attributes[FileAttributeKey.size] as! Float
//            let progress = fileSize / self.totalSize!
//            self.progressView.progress = progress
//        } catch let errorMessage {
//            print(errorMessage)
//        }

        // 方法二：
        // 思路：叠加已下载的数据的大小，计算进度
        self.currentSize += Float(data.count)
        let progress = currentSize/self.totalSize
        self.progressView.progress = progress
        self.progressLabel.text = "\(progress)"
    }
    
    // 请求完成或失败时调用
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        // 下载完成或失败，关闭文件句柄
        fileHandle?.closeFile()
        
        if error == nil {
            statusLabel.text = "下载完成"
            self.currentSize = 0
        } else {
            statusLabel.text = "下载失败"
        }
    }
}
