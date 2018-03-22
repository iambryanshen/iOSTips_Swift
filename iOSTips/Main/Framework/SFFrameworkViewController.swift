//
//  SFFrameworkViewController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/17.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFFrameworkViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = ["图片", "缺省图", "HUD", "Refresh"]
        dataSource = [["多图下载与缓存": SFImageViewController()],
                      ["在控制器上显示缺省图": SFDefaultStatusViewController(),
                       "在UIView上显示缺省图": SFUIViewController(),
                       "在UITableViewController上显示缺省图": SFTableViewController()],
                      
                      ["原生UIActivityIndicatorView": SFActivityIndicatorViewController()],
                      
                      ["UIRefreshControl": SFRefreshControlViewController(),],
        ]
        
        super.viewDidLoad()
        
    }
}
