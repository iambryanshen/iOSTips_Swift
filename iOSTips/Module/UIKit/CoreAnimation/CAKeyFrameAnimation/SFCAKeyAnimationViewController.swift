//
//  SFCAKeyAnimationViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/19.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 * 只有帧动画可以沿着贝塞尔曲线移动
 */

class SFCAKeyAnimationViewController: UIViewController {

    /*
     * iCON 抖动
     */
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func fixedPathKeyFrameAnimation(_ sender: UIButton) {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let angle1 = 5 * Float.pi / 180
        let angle2 = -5 * Float.pi / 180
        animation.values = [angle1, angle2, angle1]
        animation.repeatCount = Float.infinity
        animation.duration = 1.3
        imageView.layer.add(animation, forKey: "AnimationKey3")
    }
    
    /*
     * Fish Move
     */
    @IBOutlet weak var fishImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFishMove()
    }
    
    func makeFishMove() {
        var animationImages: [UIImage] = [UIImage]()
        for index in 0...9 {
            let animationImage = UIImage(named: "fish\(index)")
            animationImages.append(animationImage!)
        }
        fishImageView.animationImages = animationImages
        fishImageView.animationDuration = 1
        fishImageView.animationRepeatCount = Int.max
        fishImageView.startAnimating()
    }
    
    
    @IBAction func bezierPathKeyFrameAnimation(_ sender: UIButton) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 300, y: 130))
        path.addQuadCurve(to: CGPoint(x: 300, y: 600), controlPoint:  CGPoint(x: 400, y: 600))
        path.addLine(to: CGPoint(x: 100, y: 200))
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 5
        animation.rotationMode = "autoReverse"
        fishImageView.layer.add(animation, forKey: "AnimationKey4")
    }
}
