//
//  HotListNavigationView.swift
//  HotListDemo
//
//  Created by brian on 2018/1/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class NavigationTitleView: UIView {

    var buttonClick: ((Int) -> Void)?
    
    @IBAction func buttonClick(_ sender: UIButton) {
        buttonClick?(sender.tag)
    }
}
