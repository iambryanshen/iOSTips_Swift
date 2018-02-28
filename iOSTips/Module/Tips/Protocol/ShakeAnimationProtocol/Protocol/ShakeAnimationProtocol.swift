//
//  ShakeAnimationProtocol.swift
//  iOSTips
//
//  Created by Brian on 2018/1/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

protocol ShareAnimationProtocol {}

extension ShareAnimationProtocol where Self: UIView {
    
    func shakeAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.values = [-10, 0, 10, 0]
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 3
        layer.add(shakeAnimation, forKey: nil)
    }
}
