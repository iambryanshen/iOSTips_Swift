//
//  SFModalAniamtionViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/15.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFModalAniamtionViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        dataSource = [["淡入淡出动效": SFModalFadeInFadeOutViewController()],]
        
        super.viewDidLoad()
    }
}
