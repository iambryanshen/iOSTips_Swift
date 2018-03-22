//
//  SFImageFoldViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/20.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFImageFoldViewController: UIViewController {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var dragView: UIView!
    var gradientlayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 指定显示内容的部分区域，指定区域填充到整个内容区域
        // 上半部分图片显示上半部分，下半部分图片显示下半部分
        topImageView.layer.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        bottomImageView.layer.contentsRect = CGRect(x: 0, y: 0.5, width: 1, height: 0.5)
        
        // 通过移动锚点，让上半部分往上移动，下半部分往下移动
        topImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        bottomImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)

        // 给顶部的dragView添加手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        dragView.addGestureRecognizer(pan)
        
        // 添加阴影
        let gradientlayer = CAGradientLayer()
        self.gradientlayer = gradientlayer
        gradientlayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientlayer.opacity = 0
        gradientlayer.frame = bottomImageView.bounds
        bottomImageView.layer.addSublayer(gradientlayer)
    }
    
    @objc
    func pan(gesture: UIPanGestureRecognizer) {
        
        let point = gesture.location(in: gesture.view)
         
        // 动态旋转图片
        var transform = CATransform3DIdentity
        // 添加透视效果
        transform.m34 = -1 / 300
        
        let angle: CGFloat = point.y * CGFloat.pi / 200
        self.topImageView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0)
        
        // 动态调整渐变层透明度
        gradientlayer.opacity = Float(point.y / 200)
        
        // 手势松开，弹簧效果恢复原状
        if gesture.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.topImageView.layer.transform = CATransform3DIdentity
                self.gradientlayer.opacity = 0
            }, completion: nil)
        }
    }
}
