//
//  SFThread.swift
//  iOSTips
//
//  Created by brian on 2018/2/24.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 * 为什么继承Thread，是为了在SFThread中实现deinit析构方法，监听线程对象的销毁。从而验证线程的生命周期（当线程执行完任务后自动销毁）
 */
class SFThread: Thread {

    deinit {
        print(type(of: self), #function, Thread.current)
    }
}
