//
//  SFPieChart.swift
//  iOSTips
//
//  Created by brian on 2018/3/12.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFPieChartView: UIView {
    
    var dataArray: [CGFloat] = [25, 25, 50]

    /*
    override func draw(_ rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        for (_, number) in dataArray.enumerated() {
            print(startAngle, endAngle)
            startAngle = endAngle
            endAngle = startAngle + number/100 * CGFloat.pi * 2
            let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            let path = UIBezierPath(arcCenter: center, radius: bounds.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            path.close()
            context?.addPath(path.cgPath)
            context?.setFillColor(UIColor.randomColor().cgColor)
            context?.fillPath()
        }
    }
    */
    
    /*
     * 简便写法：path.fill做了三件事
     * 1. 获取上下文（UIGraphicsGetCurrentContext()）
     * 2. 添加path到上下文上（context?.addPath(path.cgPath)）
     * 3. 并渲染上下文到view的layer（context?.fillPath()）
     */
    override func draw(_ rect: CGRect) {
        
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        for (_, number) in dataArray.enumerated() {
            startAngle = endAngle
            endAngle = startAngle + number/100 * CGFloat.pi * 2
            let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            let path = UIBezierPath(arcCenter: center, radius: bounds.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            UIColor.randomColor().set()
            path.fill()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.setNeedsDisplay()
    }
}
