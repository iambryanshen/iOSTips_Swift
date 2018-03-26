//
//  SFTimerViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFTimerViewController: UIViewController {
    
    var timer: Timer?
    var index = 1
    
    /// 创建定时器方式一
    @IBAction func createTimerOne(_ sender: UIButton) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            print(self.index)
            self.index += 1
        })
    }
    
    /// 创建定时器方式二
    @IBAction func createTimerTwo(_ sender: UIButton) {
        timer = Timer(timeInterval: 5, repeats: true, block: { (timer) in
            print(self.index)
            self.index += 1
        })
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    /// 创建定时器方式三
    @IBAction func createTimerThree(_ sender: UIButton) {
        timer = Timer(fire: Date(), interval: 3, repeats: true, block: { (timer) in
            print(self.index)
            self.index += 1
        })
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }

    /// 开始定时器
    @IBAction func start(_ sender: Any) {
        timer?.fire()
    }
    
    /// 取消定时器
    @IBAction func cancel(_ sender: UIButton) {
        /**
         Stops the timer from ever firing again and requests its removal from its run loop.
         This method is the only way to remove a timer from an RunLoop object. The RunLoop object removes its strong reference to the timer, either just before the invalidate() method returns or at some later point.
         If it was configured with target and user info objects, the receiver removes its strong references to those objects as well.
         */
        timer?.invalidate()
    }
}
