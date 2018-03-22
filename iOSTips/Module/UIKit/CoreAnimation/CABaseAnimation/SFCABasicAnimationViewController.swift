//
//  SFCABaseAnimationViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/16.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFCABasicAnimationViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    @IBAction func baseAnimation(_ sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = 300
        animation.isRemovedOnCompletion = false
        animation.fillMode = "forwards"
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.duration = 1
        redView.layer.add(animation, forKey: "AnimationKey1")
    }
    
    /*
     * CABaseAnimation Example
     */
    @IBAction func heartJump(_ sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 0
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.duration = 1
        heartImageView.layer.add(animation, forKey: "AnimationKey2")
    }
}
