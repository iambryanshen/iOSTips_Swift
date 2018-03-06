//
//  SFNetworkViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/27.
//  Copyright © 2017年 brian. All rights reserved.
//

/*
 GCD和NSOperation的对比：
 1）GCD是纯C语言的API,而操作队列则是Object-C的对象。
 2）在GCD中，任务用块（block）来表示，而块是个轻量级的数据结构；
 相反操作队列中的『操作』NSOperation则是个更加重量级的Object-C对象。
 3）具体该使用GCD还是使用NSOperation需要看具体的情况
 
 NSOperation和NSOperationQueue的好处有：
 1）NSOperationQueue可以方便的调用cancel方法来取消某个操作，而GCD中的任务是无法被取消的（安排好任务之后就不管了）。
 2）NSOperation可以方便的指定操作间的依赖关系。
 3）NSOperation可以通过KVO提供对NSOperation对象的精细控制（如监听当前操作是否被取消或是否已经完成等）
 4）NSOperation可以方便的指定操作优先级。操作优先级表示此操作与队列中其它操作之间的优先关系，优先级高的操作先执行，优先级低的后执行。
 5）通过自定义NSOperation的子类可以实现操作重用.
 */

import UIKit

class SFNetworkViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = ["", "多线程", "iOS发送原生网络请求", "第三方框架实现发送网络请求", "数据解析"]
        dataSource = [["网络状态检测": SFNetworkStateViewController(),],
                      
                      ["Pthread": SFPthreadViewController(),
                       "Thread": SFThreadViewController(),
                       "GCD": SFGCDViewController(),
                       "Operation": SFOperationViewController(),],
                      
                      ["URLSession": SFURLSessionViewController(),],
                      
                      ["Alamofire": SFAlamofireViewController(),],
                      
                      ["json数据解析": SFJSONViewController(),]
        ]

        super.viewDidLoad()
    }
}
