//
//  SFCALayerViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/16.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFCALayerViewController: UIViewController {

    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 阴影
        grayView.layer.shadowOpacity = 1
        grayView.layer.shadowColor = UIColor.red.cgColor
        grayView.layer.shadowOffset = CGSize(width: 10, height: 10)

        // 设置边框
        grayView.layer.borderColor = UIColor.black.cgColor
        grayView.layer.borderWidth = 3

        // 圆角
        /*
         对纯UIView操作，不需要设置超出内容剪切
         */
        grayView.layer.cornerRadius = 50

        /*********************************************************/

        // 阴影
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowColor = UIColor.red.cgColor
        imageView.layer.shadowOffset = CGSize(width: 10, height: 10)

        // 设置边框
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3

        // 圆角
        /*
         对UIImageView，因为UIImage不是直接存储在CALayer上，是存储在layer中的content中（imageView.layer.contents），所以设置layer的cornerRadius对图片不起作用
         我们可以通过裁剪超过UIImageView的内容实现超过layer的内容不显示
            imageView.clipsToBounds = true
         也可以通过裁剪超过
            imageView.layer.masksToBounds = true
         */
        imageView.layer.cornerRadius = 65
        imageView.clipsToBounds = true
        
        /*
         注意：通过layer的属性cornerRadius、masksToBounds设置圆角的方式会触发离屏渲染，最好使用Quartz 2D的方式实现图片的圆角
         */
    }
}
