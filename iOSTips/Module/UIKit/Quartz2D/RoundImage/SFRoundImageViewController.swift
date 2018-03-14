//
//  SFRoundImageViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/13.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFRoundImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        roundImageWithBorder()
        roundImage()
    }
    
    // 不带边框的圆角图片
    func roundImage() {
        guard let image = UIImage(named: "girl") else {
            return
        }
        
        // 1. 开启一个位图上下文
        UIGraphicsBeginImageContext(CGSize(width: image.size.width, height: image.size.width))
        
        // 2. 获取一个圆形路径（用来设置圆形裁剪区域）
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.width))
        
        // 3. 设置路径为上下文的裁剪区域，超过裁剪区域以外的内容会被裁剪（对之后绘制的内容有效，对已绘制到上下文的内容无效）
        path.addClip()
        
        // 4. 把图片绘制到上下文中
        image.draw(at: CGPoint.zero)
        
        // 5. 从上下文中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 6. 手动开启的位图上下文需要手动关闭
        UIGraphicsEndImageContext()
        
        imageView.image = newImage
    }
    
    var borderWidth: CGFloat = 30
    
    // 带有边框的圆角图片
    func roundImageWithBorder() {
        
        guard let image = UIImage(named: "girl") else {
            return
        }
        
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
        
        imageView.image = newImage
    }
}
