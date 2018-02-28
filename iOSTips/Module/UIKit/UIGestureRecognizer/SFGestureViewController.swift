//
//  SFGestureViewController.swift
//  iOSLearning
//
//  Created by brian on 2018/1/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFGestureViewController: UIViewController {
    
    @IBOutlet weak var iv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iv.isUserInteractionEnabled = true
        
        addGesture()
    }
}

extension SFGestureViewController {
    func addGesture() {
        
        // 1. 添加点按手势
        addTapGesture()
        
        // 2. 添加长按手势
        addLongGesture()
        
        // 3. 添加旋转手势
        addRotationGesture()
        
        // 4. 添加拖动手势
        addPanGesture()
        
        // 5. 添加捏合手势
        addPinchGesture()
        
        // 6. 添加清扫手势
        addSwipeGesture()
    }
}

//MARK: - 点按手势
extension SFGestureViewController: UIGestureRecognizerDelegate {
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(tapGesture:)))
        tapGesture.delegate = self
        iv.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap(tapGesture: UITapGestureRecognizer) {
        print(type(of: self), #function)
    }
    
    // 通过代理方法实现UITapGestureRecognizer只在右边有效，左边无效
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let tapPoint = touch.location(in: self.iv)
        if tapPoint.x < self.iv.bounds.width * 0.5 {
            return true
        } else {
            return true
        }
    }
}

//MARK: - 长按手势
extension SFGestureViewController {
    
    func addLongGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(longTapGesture:)))
        iv.addGestureRecognizer(longGesture)
    }
    
    @objc func longTap(longTapGesture: UILongPressGestureRecognizer) {
        switch longTapGesture.state {
        case .began:
            print("began")
        case .changed:
            print("changed")
        case .ended:
            print("end")
        case .cancelled:
            print("cancel")
        default:
            print(type(of: self), #function)
        }
    }
}

//MARK: - 旋转手势
extension SFGestureViewController {
    
    func addRotationGesture() {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotation(rotationGesture:)))
        iv.addGestureRecognizer(rotationGesture)
    }
    
    @objc func rotation(rotationGesture: UIRotationGestureRecognizer) {
        let rotation = rotationGesture.rotation
        iv.transform = iv.transform.rotated(by: rotation)
        rotationGesture.rotation = 0
    }
}

//MARK: - 拖动手势
extension SFGestureViewController {
    
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(panGesture:)))
        iv.addGestureRecognizer(panGesture)
    }
    
    @objc func pan(panGesture: UIPanGestureRecognizer) {
        let panPoint = panGesture.translation(in: iv)
        iv.transform = iv.transform.translatedBy(x: panPoint.x, y: panPoint.y)
        panGesture.setTranslation(CGPoint.zero, in: iv)
    }
}

//MARK: - 捏合手势
extension SFGestureViewController {
    func addPinchGesture() {
        // 添加捏合
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(pinchGesture:)))
        iv.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinch(pinchGesture: UIPinchGestureRecognizer) {
        let scale = pinchGesture.scale
        iv.transform = iv.transform.scaledBy(x: scale, y: scale)
        pinchGesture.scale = 1
    }
}

//MARK: - 轻扫手势
extension SFGestureViewController {
    func addSwipeGesture() {
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe(swipeGesture:)))
        swipeGestureLeft.direction = .left
        iv.addGestureRecognizer(swipeGestureLeft)
        
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe(swipeGesture:)))
        swipeGestureRight.direction = .right
        iv.addGestureRecognizer(swipeGestureRight)
    }
    
    @objc func swipe(swipeGesture: UISwipeGestureRecognizer) {
        if swipeGesture.direction == .left {
            print("left")
        } else {
            print("right")
        }
    }
}
