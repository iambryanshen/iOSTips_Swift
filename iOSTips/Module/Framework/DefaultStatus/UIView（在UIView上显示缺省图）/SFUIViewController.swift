//
//  SFUIViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/26.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green

        let statusView = SFDefaultStatusView(frame: view.bounds)
        view.addSubview(statusView)
    }
}
