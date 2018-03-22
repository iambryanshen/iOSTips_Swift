//
//  SFGreenView.swift
//  iOSTips
//
//  Created by brian on 2018/3/21.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
/*
 如果给导航控制器添加了全屏滑动返回手势，会和事件传递冲突，导致调用touchCancel方法。导致UIView的拖拽出现异常：只能拖动很短的距离就会调用touchCancel方法，导致无法继续拖拽。
 所以如果希望以下代码实现拖拽UIView的功能，不要在该控制器的导航控制器中实现全屏滑动返回手势
 */

class SFGreenView: UIView {

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 1. 根据UITouch对象获取当前点和上一个点
        let touch = touches.first
        
        guard let currentPoint: CGPoint = touch?.location(in: self) else {return}
        guard let previousPoint: CGPoint = touch?.previousLocation(in: self) else {return}
        
        // 2. 通过UIView的transform属性实现平移
        let x: CGFloat = currentPoint.x - previousPoint.x
        let y: CGFloat = currentPoint.y - previousPoint.y

        self.transform = self.transform.translatedBy(x: x, y: y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(type(of: self), #function)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(type(of: self), #function)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(type(of: self), #function)
    }
}
