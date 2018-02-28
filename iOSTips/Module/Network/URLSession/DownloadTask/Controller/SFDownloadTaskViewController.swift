//
//  SFDownloadTaskViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/6.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDownloadTaskViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = [""]
        dataSource = [["Closure": SFClosureViewController(),
                       "Delegate": SFDelegateViewController()
            ],]
        
        super.viewDidLoad()
    }
}

/*
 下载数据的两种方式：
 closure块中：这种方式适合不需要监听下载进度，下载一些数据量较小的数据
 delegate中：可以监听下载进度，适合下载一些比较大的数据
 */
