//
//  SFCATransitionViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/19.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 > 转场代码和转场动画必须在同一个方法中，不考虑顺序（转场动画代码在前还是转场代码在前）
 > UINavigationController的push操作就是通过CATransition（转场动画）实现的
 */

class SFCATransitionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var index = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*
         转场代码：切换图片
         */
        imageView.image = UIImage(named: "\(index)")
        if index >= 4 {
            index = 0
        }
        index += 1
        
        
        /*
         转场动画
         */
        let transition = CATransition()
        // 动画过渡类型
        transition.type = "pageCurl"
        transition.subtype = "fromRight"
        transition.startProgress = 0.2
        transition.endProgress = 0.5
        imageView.layer.add(transition, forKey: "AnimationKey5")
    }
}
