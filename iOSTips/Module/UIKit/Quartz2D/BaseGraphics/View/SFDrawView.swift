//
//  SFLineView.swift
//  iOSTips
//
//  Created by brian on 2018/3/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDrawView: UIView {

    override func draw(_ rect: CGRect) {
        
        switch pathType {
            // 直线
        case PathType.StraightLine:
            print(type(of: self), #function)
            straightLine()
            // 指定支点的曲线
        case PathType.QuadCurveLine:
            quadCurveLine()
            // 矩形
        case PathType.Rectangle:
            rectangle()
            // 圆角矩形
        case  PathType.RoundRectangle:
            roundRectangle()
            // 指定某个角带圆角的矩形
        case PathType.SpecificRoundRectangle:
            specificRoundRectangle()
        case PathType.Oval:
            oval()
        case PathType.CircleRound1:
            circleRound1()
        case PathType.CircleRound2:
            circleRound2()
        case PathType.Arc:
            arc()
        case PathType.Simple:
            simple()
        }
    }
}

extension SFDrawView {
    
    // 直线
    func straightLine() {
        // 1. 获取和当前view关联的上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 2. 创建路径
        let path = UIBezierPath()
        
        // 2.1. 路径1
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 200, y: 200))
        
        // 2.2. 路径2
        path.move(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 250, y: 250))
        path.addLine(to: CGPoint(x: 10, y: 280))
        
        // 3. 把路径添加到上下文中
        context?.addPath(path.cgPath)
        
        // 4. 设置路径的属性
        // 4.1. 设置线的宽度
        context?.setLineWidth(20)
        // 4.2. 设置连接样式（拐弯处）
        context?.setLineJoin(CGLineJoin.round)
        // 4.3. 设置线顶角样式（两端）
        context?.setLineCap(CGLineCap.round)
        
        /*
         * 4.4. 如果直接使用set，会自动匹配渲染的模式
         * 我的理解就是，如果最终渲染是描边（stroke），那么设置的是描边的颜色，如果最终渲染是填充（fill），那么设置的是填充的颜色
         */
        UIColor.black.set()
        
        // 3. 把上下文渲染到View的layer中
        context?.strokePath()
    }
    
    // 指定支点的曲线
    func quadCurveLine() {
        
        //
        let context = UIGraphicsGetCurrentContext()
        
        // 创建曲线
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 30, y: 50))
        /*
         * controlPoint: 曲线控制点
         * to: 曲线终点
         */
        path.addQuadCurve(to: CGPoint(x: 200, y: 200), controlPoint: CGPoint(x: 30, y: 150))
        
        // 添加路径到上下文中
        context?.addPath(path.cgPath)
        context?.setStrokeColor(UIColor.blue.cgColor)
        
        // 渲染上下文到view的layer上
        context?.strokePath()
    }
    
    // 矩形
    func rectangle() {
        
        // 获取和当前View关联的上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 常规标准矩形
        let path = UIBezierPath(rect: CGRect(x: 20, y: 20, width: 200, height: 200))
        
        context?.addPath(path.cgPath)
        
        context?.strokePath()
    }
    
    // 圆角矩形
    func roundRectangle() {
        
        // 获取和当前View关联的上下文
        let context = UIGraphicsGetCurrentContext()
        
        /*
         * 带圆角的矩形，cornerRadius为圆角的度数，为0刚好是一个标准的矩形
         * 对矩形设置圆角也可以实现画圆/椭圆。（圆角等于矩形宽度的一半，如果是圆，还要保证宽、高相等）
         */
        let path = UIBezierPath(roundedRect: CGRect(x: 20, y: 20, width: 200, height: 200), cornerRadius: 20)
        
        context?.addPath(path.cgPath)
        
        context?.strokePath()
    }
    
    // 指定某个角带圆角的矩形
    func specificRoundRectangle() {
        
        // 获取和当前View关联的上下文
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath(roundedRect: CGRect(x: 20, y: 20, width: 200, height: 200), byRoundingCorners: UIRectCorner.bottomLeft, cornerRadii: CGSize(width: 80, height: 10))
        
        context?.addPath(path.cgPath)
        
        context?.strokePath()
    }
    
    // 椭圆
    func oval() {
        
        let context = UIGraphicsGetCurrentContext()
        
        // 当宽等于高时为圆
        let path = UIBezierPath(ovalIn: CGRect(x: 50, y: 20, width: 200, height: 250))
        
        context?.addPath(path.cgPath)
        UIColor.red.set()
        
        context?.strokePath()
    }
    
    // 圆形1
    func circleRound1() {
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 200, height: 200), cornerRadius: 100)
        
        context?.addPath(path.cgPath)
        
        context?.strokePath()
    }
    
    // 圆形2
    func circleRound2() {
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 200, height: 200))
        
        context?.addPath(path.cgPath)
        
        context?.fillPath()
    }
    
    // 画弧，扇形
    func arc() {
        
        let context = UIGraphicsGetCurrentContext()
        /*
         * arcCenter：弧所在的圆心
         * radius：弧所在的半径
         * startAngle：开始角度
         * endAngle：结束角度
         * clockwise：ture为顺时针，false为逆时针
         */
        let center = CGPoint(x: bounds.width/2, y: bounds.width/2)
        let path = UIBezierPath(arcCenter: center, radius: bounds.width/2 - 100, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)
        path.addLine(to: center)
        // 最后一行代码fillPath内部实现了close()实现的功能，自动关闭了path，所以该行可以省略
        path.close()
        context?.addPath(path.cgPath)
        UIColor.red.set()
        
        context?.fillPath()
    }
    
    /*
     * 简便写法：一行代码内部做了四行代码的事情
     */
    func simple() {
        let path = UIBezierPath(rect: CGRect(x: 50, y: 50, width: 100, height: 150))
        path.fill()
    }
}
