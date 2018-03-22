//
//  SFPushPopAnimationViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/15.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFPushPopAnimationViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        dataSource = [["仿AppleMusic转场动效": SFAppleMusicPushPopViewController()],]
        
        super.viewDidLoad()
    }
}
