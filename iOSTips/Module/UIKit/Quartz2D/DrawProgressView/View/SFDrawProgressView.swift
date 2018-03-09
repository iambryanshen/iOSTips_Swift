//
//  SFDrawProgressView.swift
//  iOSTips
//
//  Created by brian on 2018/3/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDrawProgressView: UIView {
    
    var progress: Float = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
 
        // 1. 获取和当前view关联的上下文
        let context = UIGraphicsGetCurrentContext()

        // 2. 绘制圆弧
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius = bounds.width/2 - 20
        let startAngle: Float = -.pi * 0.5
        let endAngle = progress * .pi * 2 + startAngle
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        
        // 3. 添加圆弧到上下文中
        context?.addPath(path.cgPath)

        // 4. 渲染上下文到view的layer上
        context?.strokePath()
    }
}
