//
//  SFDisplayLinkView.swift
//  iOSTips
//
//  Created by brian on 2018/3/12.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDisplayLinkView: UIView {
    
    var y: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /*
         * CADisplayLink定时器在每一个屏幕刷新时调用（屏幕每一秒至少刷新60次）
         */
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }

    @objc
    func update() {
        y += 5
        if y > bounds.height {
            y = 0
        }
        /*
         * setNeedsDisplay方法在屏幕刷新时会调用drawRect方法
         * 因为定时器CADisplayLink执行方法的时间（屏幕刷新时）和setNeedDisplay调用drawRect方法（屏幕刷新时重绘）的时间是一致的。所以动画会很流畅
         * 适用的场景：二维码扫描的“扫描线”
         */
        self.setNeedsDisplay()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let image = UIImage(named: "snow")
        image?.draw(at: CGPoint(x: 0, y: y))
    }
}
