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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = 300
        animation.isRemovedOnCompletion = false
        animation.fillMode = "forwards"
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.duration = 3
        redView.layer.add(animation, forKey: "animation1")
    }
}
