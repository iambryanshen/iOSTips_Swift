//
//  SFModalViewController.swift
//  iOSLearning
//
//  Created by brian on 2018/1/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubviews()
    }
}

/*
 需要了解的三个问题？
 1. present出的控制器添加到哪里？
    > 先把窗口根控制器的view移除，再把present出的VC的view添加到窗口根控制器的view上
 2. present出的控制器需不需要强引用？如果有强引用，是谁在强引用？
    > 首先肯定需要强引用，不然控制器会立即释放
    > 通过在执行完present的block：competition中打印属性presentedViewController发现，当前控制器self的属性presentedViewController强引用着present出的控制器modalChildVC
 3. 如果一个控制器没有强引用，会造成的问题？
    > 如果一个控制器没有被强引用，该控制器创建后会立即被释放，此时该控制器处理的所有业务逻辑都没有效果（所有的代码都不会执行）
 */

extension SFModalViewController {
    
    func setupSubviews() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        button.center = self.view.center
        view.addSubview(button)
        button.setTitle("present", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
    
    @objc func presentVC() {

        let modalChildVC = SFModalChildViewController()
        self.present(modalChildVC, animated: true) {
            print("modal vc success")
            print(UIApplication.shared.keyWindow?.rootViewController)
            // 通过打印发现根控制器仍然是tabBarVC,代表根控制器没有强引用present出的modelChildVC
            // 实际上present会先移除当前控制器的view，并把即将“弹出“的view添加到窗口根控制器的view上（通过看present后，app的层级关系可以发现）
            print(self.presentedViewController)
            // 通过打印该属性，发现当前控制器的属性presentedViewController正在强引用着modal出来的控制器modalChildVC
        }
    }
}
