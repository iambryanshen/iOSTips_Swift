
//
//  UIImage-Extension.swift
//  iOSTips
//
//  Created by brian on 2018/2/28.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 根据颜色（RGB值）创建image
    static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return UIImage()}
        UIGraphicsEndImageContext()
        return image
    }
    
    // 返回一张带有边框的图片，边框可为0
    static func imageWithRound(image: UIImage, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> UIImage? {
        
        // 1. 开启一个位图上下文，因为左右边框，所以需要加两倍的边框宽度
        UIGraphicsBeginImageContext(CGSize(width: image.size.width + borderWidth * 2, height: image.size.width + borderWidth * 2))
        
        // 2. 获取一个圆形路径，用来实现圆形边框的效果
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: image.size.width + borderWidth * 2, height: image.size.width + borderWidth * 2))
        
        // 3. 设置填充颜色和填充到上下文中
        UIColor.red.set()
        path.fill()
        
        // 4.获取小圆圆形区域（用来设置圆形裁剪区域）
        let clipPath = UIBezierPath(ovalIn: CGRect(x: borderWidth, y: borderWidth, width: image.size.width, height: image.size.width))
        // 5. 设置路径为上下文的裁剪区域，超过裁剪区域以外的内容会被裁剪（对之后绘制的内容有效，对已绘制到上下文的内容无效）
        clipPath.addClip()
        
        // 7. 把图片绘制到上下文中
        image.draw(at: CGPoint(x: borderWidth, y: borderWidth))
        
        // 8. 从上下文中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 9. 关闭上下文
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
