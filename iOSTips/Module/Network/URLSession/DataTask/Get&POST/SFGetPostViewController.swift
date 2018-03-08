//
//  SFGetPostViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/2.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFGetPostViewController: UIViewController {

    @IBAction func get(_ sender: UIButton) {
        get()
    }
    
    @IBAction func get1(_ sender: UIButton) {
        get1()
    }
    
    @IBAction func get2(_ sender: UIButton) {
        get2()
    }
    
    @IBAction func post(_ sender: UIButton) {
        post()
    }
    
    @IBAction func post1(_ sender: UIButton) {
        post1()
    }
}

//MARK: - get
extension SFGetPostViewController {
    
    // URL
    func get() {
        let session = URLSession.shared
        let url = URL(string: "https://httpbin.org/get")
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            print("response = ", response.debugDescription)
            print("data = ", String(bytes: data!, encoding: String.Encoding.utf8)!)
        }
        task.resume()
    }
    
    // URLRequest
    func get1() {
        let session = URLSession.shared
        let url = URL(string: "https://httpbin.org/get")
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            print("response = ", response.debugDescription)
            print("data = ", String(bytes: data!, encoding: String.Encoding.utf8)!)
        }
        task.resume()
    }
    
    // 通过代理URLSessionDelegate请求
    func get2() {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let url = URL(string: "https://httpbin.org/get")
        let task = session.dataTask(with: url!)
        task.resume()
    }
}

//MARK: - post
/*
 post请求，参数无法包含在URL中，所以无法直接通过URL创建URLSessionDataTask，必须借助URLRequest实现
 */
extension SFGetPostViewController {
    
    func post() {
        let session = URLSession.shared
        var request = URLRequest(url: loginURL!)
        request.httpMethod = "post"
        request.httpBody = "username=520it&pwd=520it&type=JSON".data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            print("response = ", response.debugDescription)
            print("data = ", String(bytes: data!, encoding: String.Encoding.utf8)!)
        }
        task.resume()
    }
    
    func post1() {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: loginURL!)
        request.httpMethod = "post"
        request.httpBody = "username=520it&pwd=520it&type=JSON".data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request)
        task.resume()
    }
}

//MARK: - URLSessionDataDelegate是URLSessionDelegate的子类
extension SFGetPostViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        print("response = ", response.debugDescription)
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("data = ", String(bytes: data, encoding: String.Encoding.utf8) ?? "")
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("error = ", error.debugDescription)
    }
}
