//
//  SFViewAnimAndCoreAnimDifferentViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/19.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 UIView动画和CoreAnimation的不同以及使用场景
 不同：
    1. UIView动画作用的是保存当前View信息的模型层，修改的是具体的属性值
    2. CoreAnimation动画作用的是Layer上，看到的都是假象，并没有修改属性的真实值
 证明：
    在下面的示例中，RedView在动画前的位置是RedView的真实位置，动画后，点击RedView，RedView不响应事件，RedView的初始位置在动画后仍然可以响应事件
 
 根据UIView动画和CoreAnimation的不同，考虑其适用场景?
 UIView动画：
    > 当需要与用户交互时
 CoreAnimation：
    > 当需要沿着某条路径做动画时
    > 转场动画使用CoreAnimation
 */

class SFViewAnimAndCoreAnimDifferentViewController: UIViewController {
    
    @IBOutlet weak var redView: SFRedView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("动画开始前，redView frame = ", redView.frame)
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = 400
        animation.isRemovedOnCompletion = false
        animation.fillMode = "forwards"
        animation.delegate = self
        redView.layer.add(animation, forKey: "AnimationKey6")
    }
}

extension SFViewAnimAndCoreAnimDifferentViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("动画开始后，redView frame = ", redView.frame)
    }
}
