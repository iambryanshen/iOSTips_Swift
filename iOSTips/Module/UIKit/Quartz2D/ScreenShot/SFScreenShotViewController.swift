//
//  SFScreenShotViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/14.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFScreenShotViewController: UIViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 1. 开启位图上下文
        /*
         * size: 位图上下文的size
         * opaque: 不透明度
         * scale: 缩放比例，为0.0默认是UIScreen.main.scale
         *      详解：比如当前屏幕尺寸为375 * 750
         *          > 如果scale为1.0，那么生成的图片尺寸等于屏幕尺寸乘以1，生成的图片尺寸等于屏幕尺寸
         *          > 如果scale为2.0，同理生成的图片尺寸等于屏幕尺寸
         *          > 如果scale为默认值0.0，那么该值默认为UIScreen.main.scale
         *              * 当手机为iPhone8时，UIScreen.main.scale == 2.0
         *              * 当手机为iPhone8 plus 或iPhone X时，UIScreen.main.scale == 3.0
         *
         */
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        
        // 2. 获取当前的上下文
        let context = UIGraphicsGetCurrentContext()

        // 3. 渲染当前屏幕显示的内容到位图上下文上
        view.layer.render(in: context!)
        
        // 4. 获取当前屏幕显示的内容（view的layer上显示的内容）
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {return}
        
        // 5. 保存内容到本地相册
        guard let imageData = UIImagePNGRepresentation(newImage) else {return}
        guard let image = UIImage(data: imageData) else {return}
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        
        // 6. 关闭位图上下文
        UIGraphicsEndImageContext()
    }

    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error == nil {
            print("成功保存截屏到系统相册")
        } else {
            print("保存截屏到系统相册失败！！!：\(String(describing: error))")
        }
    }
}
