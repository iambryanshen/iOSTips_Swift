//
//  SFGCDTimerViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFGCDTimerViewController: UIViewController {
    
    var index = 0
    
    lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: DispatchTime.now(), repeating: 1)
        timer.setEventHandler {
            self.index += 1
            print(self.index)
        }
        return timer
    }()
    
    @IBAction func start(_ sender: UIButton) {
        timer.resume()
    }
    @IBAction func pause(_ sender: UIButton) {
        index = 0
        timer.suspend()
    }
    @IBAction func cancel(_ sender: UIButton) {
        timer.cancel()
    }
    @IBAction func resume(_ sender: UIButton) {
        timer.resume()
    }
}
