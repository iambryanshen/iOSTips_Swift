//
//  SFMultipleParamViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/8.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 在OC中通过分类的方式，重写Directory。实现方法descriptionWithLocale，自动转码，输出中文
 
 多个key值相同的参数，不可以省略key值
 http://120.25.226.186:32812/weather?place=Beijing&Guangzhou        错误的写法
 http://120.25.226.186:32812/weather?place=Beijing&place=Guangzhou  正确的写法
 */

import UIKit

class SFMultipleParamViewController: UIViewController {

    @IBAction func sendOneParam(_ sender: UIButton) {
        sendRequest(number: 0)
    }
    
    @IBAction func sendTwoParam(_ sender: UIButton) {
        sendRequest(number: 1)
    }
    
    func sendRequest(number: Int) {
        let session: URLSession = URLSession.shared
        let urlString1 = "http://120.25.226.186:32812/weather?place=Beijing"
        let urlString2 = "http://120.25.226.186:32812/weather?place=Beijing&place=Guangzhou"
        let tempUrl = number == 0 ? urlString1 : urlString2
        let url = URL(string: tempUrl)!
        let dataTask: URLSessionDataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            let tempData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
            print(tempData!)
        })
        dataTask.resume()
    }
}
