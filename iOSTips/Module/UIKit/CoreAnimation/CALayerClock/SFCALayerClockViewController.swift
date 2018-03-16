//
//  SFCALayerClockViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/16.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFCALayerClockViewController: UIViewController {
    
    @IBOutlet weak var clockImageView: UIImageView!
    
    var secondLayer: CALayer!
    var minuteLayer: CALayer!
    var hourLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加时针
        addHour()
        // 添加分针
        addMinute()
        // 添加秒针
        addSecond()
        
        timeChange()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
    }
    
    func addSecond() {
        secondLayer = CALayer()
        secondLayer.backgroundColor = UIColor.red.cgColor
        secondLayer.bounds = CGRect(x: 0, y: 0, width: 1, height: 80)
        secondLayer.position = CGPoint(x: clockImageView.bounds.width * 0.5, y: clockImageView.bounds.height * 0.5)
        secondLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        clockImageView.layer.addSublayer(secondLayer)
    }
    
    func addMinute() {
        minuteLayer = CALayer()
        minuteLayer.backgroundColor = UIColor.black.cgColor
        minuteLayer.bounds = CGRect(x: 0, y: 0, width: 2, height: 60)
        minuteLayer.position = CGPoint(x: clockImageView.bounds.width * 0.5, y: clockImageView.bounds.height * 0.5)
        minuteLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        clockImageView.layer.addSublayer(minuteLayer)
    }
    
    func addHour() {
        hourLayer = CALayer()
        hourLayer.backgroundColor = UIColor.black.cgColor
        hourLayer.bounds = CGRect(x: 0, y: 0, width: 3, height: 50)
        hourLayer.position = CGPoint(x: clockImageView.bounds.width * 0.5, y: clockImageView.bounds.height * 0.5)
        hourLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        clockImageView.layer.addSublayer(hourLayer)
    }
    
    @objc
    func timeChange() {
        
        // 获取当前时间
        let calendar = Calendar.current
        let result = calendar.dateComponents([Calendar.Component.second, Calendar.Component.minute, Calendar.Component.hour], from: Date())
        
        let hour = result.hour ?? 0
        let minute = result.minute ?? 0
        let second = result.second ?? 0
        
        // 当前秒 x 一秒钟旋转的度数
        let secondAngle = CGFloat(second) * (2 * .pi / 60)
        // 当前分钟 x 一分钟旋转的度数
        let minuteAngle = CGFloat(minute) * (2 * .pi / 60)
        // 当前的小时 x 一小时旋转的度数 + 每一分钟，时针旋转的度数
        let hourAngle = CGFloat(hour) * (2 * .pi / 12) + CGFloat(minute) / 60 * .pi/6
        
        secondLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1)
        minuteLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
        hourLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1)
    }
}
