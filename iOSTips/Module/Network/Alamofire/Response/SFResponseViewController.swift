//
//  SFResponseViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/23.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Alamofire

/*
 Alamofire对返回的结果提供了5种处理方式，分别如下
 */

class SFResponseViewController: UIViewController {

    // 直接返回原始结果不做任何处理
    @IBAction func response(_ sender: UIButton) {
        
        Alamofire.request("https://httpbin.org/get").response { (dataResponse) in
            print(dataResponse)
        }
    }
    
    // 返回结果转化为Data类型
    @IBAction func responseData(_ sender: UIButton) {
        Alamofire.request("https://httpbin.org/get").responseData { (dataResponse) in
            print(dataResponse.result.value)
        }
    }
    
    // 返回结果转化为JSON类型
    @IBAction func responseJSON(_ sender: UIButton) {
        Alamofire.request("https://httpbin.org/get").responseJSON { (dataResponse) in
            print(dataResponse.result.value)
        }
    }
    
    // 返回结果转化为String
    @IBAction func responseString(_ sender: UIButton) {
        Alamofire.request("https://httpbin.org/get").responseString { (dataResponse) in
            print(dataResponse.result.value)
        }
    }

    // 返回结果转化为Any类型
    @IBAction func responseAny(_ sender: UIButton) {
        Alamofire.request("https://httpbin.org/get").responsePropertyList { (dataResponse) in
            print(dataResponse.result.value)
        }
    }
    
    
}
