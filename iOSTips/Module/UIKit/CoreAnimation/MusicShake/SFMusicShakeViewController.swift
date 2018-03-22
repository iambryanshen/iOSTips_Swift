//
//  SFMusicShakeViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/20.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFMusicShakeViewController: UIViewController {

    @IBOutlet weak var lightGrayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加复制层
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = lightGrayView.bounds
        replicatorLayer.backgroundColor = UIColor.lightGray.cgColor
        lightGrayView.layer.addSublayer(replicatorLayer)

        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        let height: CGFloat = 150
        layer.bounds = CGRect(x: 0, y: 0, width: 30, height: height)
        layer.anchorPoint = CGPoint(x: 0, y: 1)
        layer.position = CGPoint(x: 0, y: lightGrayView.bounds.height)
        replicatorLayer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.toValue = 0
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.duration = 0.5
        layer.add(animation, forKey: "MusicShake")
        
        // 设置复制的份数
        replicatorLayer.instanceCount = 5
        // 设置复制层的动画延迟时间
        replicatorLayer.instanceDelay = 0.5
        // 对复制出来的子层做形变的操作
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(50, 0, 0)
    }
}
