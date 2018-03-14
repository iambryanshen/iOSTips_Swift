//
//  SFImageWaterMarkViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/13.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFImageWaterMarkViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "girl") else {
            return
        }
        
        // 1. 开启位图上下文，同时需要指定上下文的大小（该大小就是即将生成的图片的尺寸大小）
        UIGraphicsBeginImageContext(image.size)
        
        // 2. 把图片画到上下文上
        image.draw(at: CGPoint.zero)
        
        // 3. 画水印文字到上下文上
        let textString: NSString = "湖南女孩"
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 200), NSAttributedStringKey.foregroundColor: UIColor.green]
        textString.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        
        // 4. 从上下文中生成一张图片（合成上下文中的全部内容，生成一张和上下文尺寸大小相同的图片）
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5. 关系上下文（自己生成的上下文需要手动关闭）
        UIGraphicsEndImageContext()
        
        
        imageView.image = newImage
    }
}
