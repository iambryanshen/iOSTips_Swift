//
//  SFNetworkViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/27.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFNetworkViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = ["", "多线程", "iOS发送原生网络请求", "第三方框架实现发送网络请求", "数据解析"]
        dataSource = [["网络状态检测": SFNetworkStateViewController(),],
                      
                      ["Pthread": SFPthreadViewController(),
                       "Thread": SFThreadViewController(),
                       "GCD": SFGCDViewController(),],
                      
                      ["URLSession": SFURLSessionViewController(),],
                      
                      ["Alamofire": SFAlamofireViewController(),],
                      
                      ["json数据解析": SFJSONViewController(),]
        ]

        super.viewDidLoad()
    }
}
