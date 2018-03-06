//
//  SFCustomOperation.swift
//  iOSTips
//
//  Created by brian on 2018/3/6.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/* 自定义操作继承基类（Operation），Operation类不直接实现，一般使用子类BlockOperation，InvocationOperation（在swift中已废弃，在Objc中仍然可以继续使用）
 * 在自定义的操作类中封装任务，可以更好的实现代码的分离和复用
 *
 * 注意：自定义操作中main方法中的全部内容为一个操作，cancelAllOperations只会取消队列中处于等待状态（没有开始执行的操作）的操作。因为自定义操作main方法中的全部内容为一个操作，所以当执行cancelAllOperations时，仍然会等main方法中的全部内容执行完才会结束操作。
 * 解决方法是：Operation中有一个isCancelled属性，当执行cancelAllOperations方法时，该属性的值会又false变为true，通过在操作中合适的位置，判断该属性的值，如果该值为true，直接返回，结束执行任务。
 */

class SFCustomOperation: Operation {
    
    override func main() {
        print("在自定义的操作中封装任务", Thread.current)
        
        for index in 0...10000 {
            print("1-------\(index)耗时操作,模拟下载、上传类似任务", Thread.current)
        }
        
        if isCancelled {
            return
        }
        
        print("**************************************")
        
        for index in 0...1000 {
            print("2-------\(index)耗时操作,模拟下载、上传类似任务", Thread.current)
        }
        
        
        if isCancelled {
            return
        }
        
        print("**************************************")
        
        for index in 0...1000 {
            print("3-------\(index)耗时操作,模拟下载、上传类似任务", Thread.current)
        }
    }
}
