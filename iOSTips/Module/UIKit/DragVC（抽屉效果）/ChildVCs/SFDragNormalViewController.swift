//
//  SFDragNormalViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/3.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDragNormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray
        
        let label = UILabel()
        label.text = "我是普通VC"
        label.font = UIFont(name: "PingFang SC-Semibold", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        view.addSubview(label)
        label.sizeToFit()
        label.center = view.center
    }
}
