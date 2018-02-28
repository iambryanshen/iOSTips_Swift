//
//  SFGCDViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFGCDViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        dataSource = [["GCD的任务与队列": SFFunctionQueueViewController(),
                       "GCD的遍历与队列组": SFApplyGroupViewController(),]]
        
        super.viewDidLoad()
    }
}
