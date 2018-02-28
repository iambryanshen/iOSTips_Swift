//
//  SFTransformViewController.swift
//  iOSLearning
//
//  Created by brian on 2018/1/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFTransformViewController: UIViewController {
    
    @IBOutlet weak var iv: UIImageView!

    // 平移
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!

    // 旋转
    @IBOutlet weak var angleTextField: UITextField!
    
    // 缩放
    @IBOutlet weak var scaleXTextField: UITextField!
    @IBOutlet weak var scaleYTextField: UITextField!
    
    //MARK: - 平移
    @IBAction func translate(_ sender: UIButton) {
        let x = Double(xTextField.text ?? "0")
        let y = Double(yTextField.text ?? "0")
        if let tempX = x, let tempY = y {
            UIView.animate(withDuration: 1, animations: {
                self.iv.transform = CGAffineTransform(translationX: CGFloat(tempX), y: CGFloat(tempY))
            })
        }
    }
    @IBAction func translateMake(_ sender: UIButton) {
        let x = Double(xTextField.text ?? "0")
        let y = Double(yTextField.text ?? "0")
        if let tempX = x, let tempY = y {
            UIView.animate(withDuration: 1, animations: {
                self.iv.transform = self.iv.transform.translatedBy(x: CGFloat(tempX), y: CGFloat(tempY))
            })
        }
    }
    
    //MARK: - 旋转
    @IBAction func rotation(_ sender: UIButton) {
        let angle = Double(angleTextField.text ?? "0")
        if let angle = angle {
            UIView.animate(withDuration: 1, animations: {
                // Double.pi == π
                self.iv.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            })
        }
    }
    @IBAction func rotationMake(_ sender: UIButton) {
        let angle = Double(angleTextField.text ?? "0")
        if let angle = angle {
            UIView.animate(withDuration: 1, animations: {
                // Double.pi == π
                self.iv.transform = self.iv.transform.rotated(by: CGFloat(angle))
            })
        }
    }
    
    //MARK: - 缩放
    @IBAction func scale(_ sender: UIButton) {
        let scaleX = Double(scaleXTextField.text ?? "0")
        let scaleY = Double(scaleXTextField.text ?? "0")
        if let tempScaleX = scaleX, let tempScaleY = scaleY {
            UIView.animate(withDuration: 1, animations: {
                self.iv.transform = CGAffineTransform(scaleX: CGFloat(tempScaleX), y: CGFloat(tempScaleY))
            })
        }
    }
    
    @IBAction func scaleMake(_ sender: UIButton) {
        let scaleX = Double(scaleXTextField.text ?? "0")
        let scaleY = Double(scaleXTextField.text ?? "0")
        if let tempScaleX = scaleX, let tempScaleY = scaleY {
            UIView.animate(withDuration: 1, animations: {
                self.iv.transform = self.iv.transform.scaledBy(x: CGFloat(tempScaleX), y: CGFloat(tempScaleY))
            })
        }
        
        // 验证得到，经过transform的UIView，frame都会发生改变，效果等同于UIView动画修改frame实现的动画效果
        print(iv.frame)
    }
    
    @IBAction func resetClick(_ sender: UIButton) {
        iv.transform = .identity
    }
}

extension SFTransformViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
