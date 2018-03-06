//
//  SFCustomThread.swift
//  iOSTips
//
//  Created by brian on 2018/3/6.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 * 在自定义的线程中重写main方法，封装任务
 * 这种方式可以使得任务代码独立且更好复用，比如同一种任务（下载任务），在其他地方只需要创建该线程对象即可（let customThread = SFCustomThread()）
 */

import UIKit

class SFCustomThread: Thread {
    
    override func main() {
        print("自定义线程中封装的任务", Thread.current)
    }
    
    deinit {
        print("监听自定义线程的销毁")
    }
}
