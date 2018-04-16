//
//  SFOperationViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/5.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 * Operation是基类，不直接使用，一般使用子类：BlockOperation、InvocationOperation（在swift中废弃，在Objc中仍然可以使用）
 * 通过Operation封装任务的operation对象，需要执行start方法，让任务开始执行。
 *      let operation = BlockOperation{
            print("封装任务")
        }
        operation.start()
 * 如果添加了操作（operation）到队列（queue）中，会自动执行start方法（start方法内部会调用main方法）
        let queue = OperationQueue()
        queue.addOperation(operation)
        //不再需要执行operation.start(),添加到queue中的operation会自动执行start方法
 *
 * 自定义操作：SFCustomOperation，在自定义的操作对象中重写main方法，可以更好的分离复用代码
 *
 * 操作之间的依赖：Operation比GCD更强大，即使操作添加到不同队列中，依然可以完成不同操作之间的依赖
 *
 * 操作的监听：通过Operation的completionBlock属性实现对操作的监听，该属性的值在操作执行结束后执行
 *
 */

import UIKit

class SFOperationViewController: UIViewController {
    
    var queue: OperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue = OperationQueue()
    }
    
    //MARK: - block封装任务到操作中
    // BlockOperation操作
    @IBAction func blockOperation(_ sender: UIButton) {
        
        // Block中的任务数量超过1时，就会开启子线程执行任务
        let operation1 = BlockOperation {
            print("1---", Thread.current)
        }
        let operation2 = BlockOperation {
            print("1---", Thread.current)
        }
        let operation3 = BlockOperation {
            print("1---", Thread.current)
        }
        
        // 追加操作
        operation3.addExecutionBlock {
            print("2---", Thread.current)
        }
        operation3.addExecutionBlock {
            print("3---", Thread.current)
        }
        
        operation1.start()
        operation2.start()
        operation3.start()
    }

    //MARK: - 函数式封装任务到操作中
    /// 在Swift中没有函数式封装操作，函数式封装操作只存在于Objc中
    @IBAction func funcOperation(_ sender: UIButton) {}

    //MARK: - 操作与队列
    // 添加封装好的操作operation到队列queue中，queue队列内部自动调用operation.start()
    @IBAction func operationQueue(_ sender: UIButton) {
        
        let operation1 = BlockOperation {
            for index in 0...50000 {
                print("1---\(index)---", Thread.current)
            }
        }
        let operation2 = BlockOperation {
            for index in 0...50000 {
                print("2---\(index)---", Thread.current)
            }
        }
        let operation3 = BlockOperation {
            for index in 0...50000 {
                print("3---\(index)---", Thread.current)
            }
        }
        
        // 最大并发数：同一时间同时执行的线程数量。如果设为1，线程中同时执行的线程数量只有1个，相当于变相改变队列为串行队列。
        queue?.maxConcurrentOperationCount = 1
        
        // 添加操作到队列中，会自动调用操作的start方法，执行操作
        queue?.addOperation(operation1)
        queue?.addOperation(operation2)
        queue?.addOperation(operation3)
    }
    
    //MARK: - 挂起操作
    @IBAction func suspendQueue(_ sender: UIButton) {
        // 只能暂停队列中处于等待状态的操作
        queue?.isSuspended = true
    }
    
    //MARK: - 恢复操作
    @IBAction func resumeQueue(_ sender: UIButton) {
        queue?.isSuspended = false
    }
    
    //MARK: - 取消操作
    @IBAction func cancelQueue(_ sender: UIButton) {
        // 只能取消队列中处于等待状态的操作
        queue?.cancelAllOperations()
    }
    
    //MARK: - 自定义操作
    // 自定义操作类，在自定义的操作类中重写main方法，封装任务
    @IBAction func customOperation(_ sender: UIButton) {
        let customOperation = SFCustomOperation()
        queue?.addOperation(customOperation)
    }
    
    //MARK: - 操作之间的依赖
    /*
     * 操作之间的依赖，一个操作依赖于另外一个操作执行完成后执行
     * Operation比GCD更强大，可以实现多个队列之间的操作依赖
     */
    @IBAction func operationDependency(_ sender: UIButton) {
        
        let operation1 = BlockOperation {
            print("操作1执行")
        }
        
        let operation2 = BlockOperation {
            print("操作2执行")
        }
        
        let operation3 = BlockOperation {
            print("操作3执行")
        }
        
        let operation4 = BlockOperation {
            print("操作4执行")
        }
        
        operation1.addDependency(operation2)
        operation2.addDependency(operation3)
        operation3.addDependency(operation4)
        
        queue?.addOperation(operation1)
        queue?.addOperation(operation2)
        queue?.addOperation(operation3)
        
        // 虽然此处任务4是添加到了队列queue1中，仍然可以完成四个操作（operation1、operation2、operation3、operation4）之间的依赖关系
        let queue1 = OperationQueue()
        queue1.addOperation(operation4)
    }
    
    //MARK: - 操作完成的监听
    /*
     * 一个操作结束后做某件事：下载完成后通知用户下载成功了
     */
    @IBAction func operationMonitor(_ sender: UIButton) {
        
        let operation = BlockOperation {
            print("操作一执行中...")
        }
        
        operation.completionBlock = {
            print("主人，操作一结束了")
        }
        
        queue?.addOperation(operation)
    }
    
    //MARK: - 监听操作的某个属性值的改变（比如：当取消操作时，isCanceled属性为true）
    @IBAction func operationPropertyChange(_ sender: UIButton) {
        let customOperation = SFCustomOperation()
        customOperation.addObserver(self, forKeyPath: "isCancelled", options: NSKeyValueObservingOptions.new, context: nil)
        queue?.addOperation(customOperation)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("点击了取消， isCancelled属性值为true")
    }
    
    
    //MARK: - 线程间的通信
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func threadCommunication(_ sender: UIButton) {
        
        // 创建队列
        let queue = OperationQueue()
        
        // 创建操作
        let operation = BlockOperation {
            
            let url = URL(string: "https://wx4.sinaimg.cn/mw690/daadc8c5ly1fnivagl9kwj235s23xe82.jpg")
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            
            // 回到主线程刷新UI
            OperationQueue.main.addOperation({
                self.imageView.image = image
            })
        }
        
        // 添加操作到队列中
        queue.addOperation(operation)
    }
}
