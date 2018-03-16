//
//  SFContextMatrixOperationsView.swift
//  iOSTips
//
//  Created by brian on 2018/3/13.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 * 上下文的矩阵操作就是对上下文进行：平移，缩放，旋转等操作。需要在路径添加到上下文之前进行
 */

class SFContextMatrixOperationsView: UIView {

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()

        let path = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 200, height: 130))

        // 矩阵操作：平移
        context?.translateBy(x: 0, y: 200)
        // 矩阵操作：缩放
        context?.scaleBy(x: 0.8, y: 1.3)
        // 矩阵操作：旋转
        context?.rotate(by: .pi/6)

        // 注意:矩阵操作要在路径添加前进行，否则对所添加的路径无效
        context?.addPath(path.cgPath)

        context?.strokePath()
    }
}
