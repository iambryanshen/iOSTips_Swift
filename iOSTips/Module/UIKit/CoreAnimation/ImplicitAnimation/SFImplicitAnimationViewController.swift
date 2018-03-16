//
//  SFImplicitAnimationViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/16.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFImplicitAnimationViewController: UIViewController {
    
    var layer: CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(layer)
        
    }
    
    @IBAction func defaultAnimation(_ sender: UIButton) {
        
        layer.position = self.view.center
        layer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    @IBAction func customAnimation(_ sender: UIButton) {
        
        /*
         每一个UIView都有一个CALayer，该CALayer没有隐式动画
         除了这种和UIView关联的CALayer，其他通过自己创建的CALayer都有隐式动画
         隐式动画会出现在修改自己创建的CALayer的一些特定的可动画属性时出现，比如position、bounds等等
         要想关闭自己创建的CALayer这种默认就有的隐式动画，可以通过事务的方式来修改。
         
         如何修改？
         通过CATransaction.setDisableAction(true)设置既可。
         
         如果只想对某几个属性修改时产生的动画进行设置？
         我们通过在开启事务和提交事务之间包含这几行修改某几个属性的代码，实现对某几个属性的隐式动画的设置
         */
        
        // 开启一个事务
        CATransaction.begin()
        
        // 设置是否需要隐式动画
        CATransaction.setDisableActions(false)
        // 设置隐式动画的时间
        CATransaction.setAnimationDuration(3)
        
        /*
         修改layer的可动画属性，会产生“过渡效果的“隐式动画
         常见的可动画属性：position、bounds、cornerRadius、backgroundColor等等
         */
        layer.position = self.view.center
        layer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        // 提交一个事务
        CATransaction.commit()
        
        
        // 该属性在ATransaction.begin()和CATransaction.commit()之外，其隐式动画不受事务的控制。不会被改变，呈默认状态。
        layer.cornerRadius = 100
    }
}
