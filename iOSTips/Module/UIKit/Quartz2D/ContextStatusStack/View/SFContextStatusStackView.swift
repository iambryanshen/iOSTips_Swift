//
//  SFContextStatusStackView.swift
//  iOSTips
//
//  Created by brian on 2018/3/13.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFContextStatusStackView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
     
//        normal()
//        wrong()
        contextStatusStack()
    }
    
    /*
     * 错误的思路
     */
    func wrong() {
        
        let context = UIGraphicsGetCurrentContext()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 100))
        path.addLine(to: CGPoint(x: 180, y: 100))

        context?.addPath(path.cgPath)

        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(10)

        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 100, y: 20))
        path1.addLine(to: CGPoint(x: 100, y: 180))

        context?.addPath(path1.cgPath)

        /*
         * 会覆盖上面的状态（red，10），导致路径都是green、20
         */
        context?.setStrokeColor(UIColor.green.cgColor)
        context?.setLineWidth(20)

        context?.strokePath()
    }
    
    /*
     * 不使用上下文状态栈实现画不同颜色的“十”字
     */
    func normal() {
        // 1. 获取当前view相关联的上下文
        /*
         * 获取上下文相当于开辟了一块内存空间
         * 该内存空间分为两部分
         *  1. 存储路径
         *  2. 存储路径的状态（UIColor，Width）
         */
        let context = UIGraphicsGetCurrentContext()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 20))
        path.addLine(to: CGPoint(x: 100, y: 180))

        context?.addPath(path.cgPath)

        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(10)

        // 取出上下文中所有绘制的路径，并把上下文中存储的路径状态应用到所有的路径上，渲染到上下文关联的view的layer上
        context?.strokePath()

        /************************分割线************************/

        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 20, y: 100))
        path1.addLine(to: CGPoint(x: 180, y: 100))

        context?.addPath(path1.cgPath)

        context?.setStrokeColor(UIColor.green.cgColor)
        context?.setLineWidth(20)

        context?.strokePath()
    }
    
    func contextStatusStack() {
        // 1. 获取当前view相关联的上下文
        /*
         * 获取上下文相当于开辟了一块内存空间
         * 该内存空间分为两部分
         *  1. 存储路径
         *  2. 存储路径的状态（UIColor，Width）
         */
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 100))
        path.addLine(to: CGPoint(x: 180, y: 100))

        context?.addPath(path.cgPath)
        
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(10)
        
        /*
         * 保存上下文中存储的状态到上下文状态栈中（栈：先进后出）
         * 保存了：color：green，width：20到上下文状态栈中
         */
        context?.saveGState()
        
        
        context?.setStrokeColor(UIColor.green.cgColor)
        context?.setLineWidth(20)
        
        // 取出上下文中所有绘制的路径，并把上下文中存储的路径状态应用到所有的路径上，渲染到上下文关联的view的layer上
        context?.strokePath()
        
        /***************************************/
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 100, y: 20))
        path1.addLine(to: CGPoint(x: 100, y: 180))

        context?.addPath(path1.cgPath)

        /*
         * 从当前上下文的状态栈中，取出栈顶的（最后存入的状态：color：green，width：20）状态，覆盖上下文中存储的状态
         */
        context?.restoreGState()

        context?.strokePath()
    }
}
