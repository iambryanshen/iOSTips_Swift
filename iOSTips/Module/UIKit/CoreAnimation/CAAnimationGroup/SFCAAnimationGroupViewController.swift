//
//  SFCAAnimationGroupViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/19.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFCAAnimationGroupViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let animation1 = CABasicAnimation(keyPath: "position.y")
        animation1.toValue = 400
        
        let animation2 = CABasicAnimation(keyPath: "transform.scale")
        animation2.toValue = 0.5
        
        // 创建动画组，用动画组包含多个动画
        let group = CAAnimationGroup()
        group.animations = [animation1, animation2]
        group.fillMode = "forwards"
        group.isRemovedOnCompletion = false
        
        redView.layer.add(group, forKey: "group")
    }
}
