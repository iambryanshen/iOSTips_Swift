//
//  SFCATransform3DViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/16.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFCATransform3DViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func rotation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
//            self.imageView.layer.transform = CATransform3DMakeRotation(.pi, 0, 0, 1)
            self.imageView.layer.transform = CATransform3DRotate(self.imageView.layer.transform, .pi, 0, 0, 1)
//            self.imageView.layer.setValue(CGFloat.pi, forKeyPath: "transform.rotation.x")
        }
    }
    
    @IBAction func translation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
//            self.imageView.layer.transform = CATransform3DMakeTranslation(100, 100, 100)
            self.imageView.layer.transform = CATransform3DTranslate(self.imageView.layer.transform, 100, 100, 100)
//            self.imageView.layer.setValue(100, forKeyPath: "transform.translation.x")
        }
    }
    
    @IBAction func scale(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
//            self.imageView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            self.imageView.layer.transform = CATransform3DScale(self.imageView.layer.transform, 1.5, 1.5, 1.5)
//            self.imageView.layer.setValue(1.5, forKeyPath: "transform.scale.x")
        }
    }
}
