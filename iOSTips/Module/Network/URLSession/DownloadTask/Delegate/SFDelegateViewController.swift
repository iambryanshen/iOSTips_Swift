//
//  SFDelegateViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/6.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 URLDownloadTask无法实现离线下载功能，如果需要实现离线下载功能，只能通过URLDataTask。
 原因：数据下载过程中意外退出App，无法拿到resumeData数据，该数据只有执行取消操作才会生成。如果想通过手动执行取消操作拿到数据，也无法实现，原因是当App退出时会先销毁会话对象session和下载任务DownloadTask，没有DownloadTask无法执行取消操作
 */

import UIKit

class SFDelegateViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // 用来实现断点续传的恢复信息
    var resumeData: Data?

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    lazy var downloadTask: URLSessionDownloadTask = {
        let url = URL(string: "resources/videos/minion_01.mp4", relativeTo: baseURL)
        let request = URLRequest(url: url!)
        let downloadTask = session.downloadTask(with: request)
        self.downloadTask = downloadTask
        return downloadTask
    }()
    
    @IBAction func startDownload(_ sender: UIButton) {
        downloadTask.resume()
        statusLabel.text = "下载中..."
    }
    @IBAction func suspendDownload(_ sender: UIButton) {
        downloadTask.suspend()
        statusLabel.text = "已暂停"
    }
    @IBAction func resumeSuspendDownload(_ sender: UIButton) {
        // 如果有已经下载的数据信息
        if let resumeData = resumeData {
            // 通过这些已经下载的数据信息创建的下载对象可以继续接着上次下载的数据继续下载
            downloadTask = session.downloadTask(withResumeData: resumeData)
        }
        downloadTask.resume()
        statusLabel.text = "继续下载..."
    }
    @IBAction func cancelDownload(_ sender: UIButton) {
        // 通过这种方式取消，拿不到任何下载的数据信息，无法实现断点续传
        // downloadTask.cancel()
        // 通过这种方式取消，可以拿到目前已下载成功的数据的“info”，通过这些信息还可以实现“断点续传”的功能
        downloadTask.cancel(byProducingResumeData: { (resumeData) in
            self.resumeData = resumeData
        })
        statusLabel.text = "已取消"
    }
}

//MARK: - URLSessionDownloadDelegate
extension SFDelegateViewController: URLSessionDownloadDelegate {
    
    // 往沙盒中写接收到的数据的时候调用
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        // 计算下载进度
        let progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        // 设置下载进度
        self.progressView.progress = progress
        self.progressLabel.text = "\(progress)"
    }

    // 下载完成时调用
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let fullPath = cachePath + "/" + (downloadTask.response?.suggestedFilename ?? "")
        // 注意：创建保存文件目录URL时，需要通过fileURLWithPath创建，这样创建的URL前面会有:file://
        let fullPathURL = URL(fileURLWithPath: fullPath)
        do {
            try FileManager.default.moveItem(at: location, to: fullPathURL)
        } catch let errorMessage {
            print("移动文件失败! errorMessage = ", errorMessage)
        }
    }

    // 整个请求结束时或失败时调用
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            statusLabel.text = "下载成功"
        } else {
            statusLabel.text = "下载失败"
        }
    }
}
