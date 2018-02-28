//
//  SFDragViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/3.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDragViewController: UIViewController {
    
    lazy var leftView: UIView = {
        let leftView: UIView = UIView(frame: self.view.bounds)
        leftView.backgroundColor = UIColor.red
        return leftView
    }()
    
    lazy var mainView: UIView = {
        let mainView: UIView = UIView(frame: self.view.bounds)
        mainView.backgroundColor = UIColor.green
        return mainView
    }()
    
    lazy var rightView: UIView = {
        let rightView: UIView = UIView(frame: self.view.bounds)
        rightView.backgroundColor = UIColor.blue
        return rightView
    }()
    
    // 滑动缩放比例
    var scale: CGFloat = 0.7
    // 初始显示的view停留在左侧或右侧所剩的显示的宽度
    var target: CGFloat = 100
    // 拖动松手后的动效时长
    var animationTime: TimeInterval = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        addGesture()
    }
}

//MARK: - 添加子控件
fileprivate extension SFDragViewController {
    
    func setupSubviews() {
        view.addSubview(leftView)
        view.addSubview(rightView)
        view.addSubview(mainView)
    }
}

//MARK: - 实现拖拽
fileprivate extension SFDragViewController {
    
    func addGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(panGesture:)))
        mainView.addGestureRecognizer(pan)
    }
    
    @objc func pan(panGesture: UIPanGestureRecognizer) {
        
        let point = panGesture.translation(in: mainView)
        moveMainViewWithOffset(offset: point.x)
        panGesture.setTranslation(CGPoint.zero, in: mainView)
        
        if panGesture.state == .ended {
         
            if mainView.frame.origin.x > view.bounds.width * 0.5 {
                // 定位到屏幕的右侧
                UIView.animate(withDuration: animationTime, animations: {
                    let offset = self.view.bounds.width - self.target - self.mainView.frame.origin.x
                    self.moveMainViewWithOffset(offset: offset)
                })
            } else if mainView.frame.maxX < view.bounds.width * 0.5 {
                // 定位到屏幕左侧
                UIView.animate(withDuration: animationTime, animations: {
                    let offset = self.target - self.mainView.frame.maxX
                    self.moveMainViewWithOffset(offset: offset)
                })
            } else {
                UIView.animate(withDuration: animationTime, animations: {
                    self.mainView.frame = self.view.bounds
                })
            }
        }
    }
    
    // 根据滑动的距离设置mainView的缩放和位置
    func moveMainViewWithOffset(offset: CGFloat) {
        
        // 移动mainView
        mainView.frame.origin.x = mainView.frame.origin.x + offset
        
        // 缩放mainView：通过修改y和height实现
        mainView.frame.origin.y = fabs(mainView.frame.origin.x / view.bounds.width * (1 - scale) * view.bounds.height * 0.5)
        mainView.frame.size.height = view.bounds.height - 2 * mainView.frame.origin.y
        
        if mainView.frame.origin.x < 0 {
            rightView.isHidden = false
        } else {
            rightView.isHidden = true
        }
    }
}

//MARK: - 对外接口，打开和关闭
extension SFDragViewController {
    func openLeft() {
        UIView.animate(withDuration: animationTime) {
            self.moveMainViewWithOffset(offset: self.view.bounds.width - self.target)
        }
    }
    
    func openRight() {
        UIView.animate(withDuration: animationTime) {
            self.moveMainViewWithOffset(offset: -self.target)
        }
    }
    
    func close() {
        UIView.animate(withDuration: animationTime) {
            self.mainView.frame = self.view.bounds
        }
    }
}
