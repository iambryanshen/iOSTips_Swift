//
//  SFURLSessionViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/2.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFURLSessionViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        dataSource = [["URLSessionDataTask": SFDataTaskViewController(),
                       "URLSessionDownloadTask": SFDownloadTaskViewController(),
                       "URLSessionUploadTask": SFUploadTaskViewController()]]
        
        super.viewDidLoad()
    }
}
