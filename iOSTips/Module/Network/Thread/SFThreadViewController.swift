//
//  SFThreadViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/24.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 * Thread：
 * 一. 可以通过以下三种方式创建子线程
 *  ①：Thread(target: self, se... 优点：可以拿到线程对象。对线程进行进一步的设置（设置线程名称，优先级）。缺点：需要手动开启
 *  ②：detachNewThreadSelector... 优点：无需手动开启。缺点：拿不到线程对象
 *  ③：performSelector...         优缺点同②
 * 二. 设置线程对象的名称
 * 三. 设置线程对象的优先级（0~1）：优先级高的被CPU调度的可能性更高
 * 四. 线程的生命周期：当子线程执行的任务执行完毕时，线程对象销毁
 * 五. 控制线程的状态
    ①： start：执行start，线程会被添加到可调度线程池中，此时线程的状态为“就绪状态”。线程为“就绪状态”时，CPU只会调用可调度线程池中的线程
    ②： sleep：由“运行状态”转换为“阻塞状态”，此时线程会被移出可调度线程池。不再被CPU调度。当达到指定时间时，线程继续执行。
    ③： exit：强制退出。无论线程是什么状态，执行exit()，线程都会强制退出，线程执行的任务不再继续执行。
 * 六. 自定义队列 Custom Thread
 */

/*
 * 回到主线程的两种方式：
 *      ①：self.performSelector(onMainThread: <#T##Selector#>, with: <#T##Any?#>, waitUntilDone: <#T##Bool#>)
 *          > 优点：无需获取主线程
 *          > 缺点：只能在主线程中执行方法
 *      ②：self.perform(<#T##aSelector: Selector##Selector#>, on: <#T##Thread#>, with: <#T##Any?#>, waitUntilDone: <#T##Bool#>)
 *          > 优点：可以在任意线程执行方法
 *          > 缺点：在主线程中执行方法，比①多了一步获取主线程的操作
 */

class SFThreadViewController: UIViewController {

    //MARK: - 通过Thread创建线程的三种方式
    // 方式一：可以拿到线程对象，对线程进行进一步的设置
    @IBAction func createChildThread(_ sender: UIButton) {
        print(type(of: self), #function, Thread.current)
        let thread = Thread(target: self, selector: #selector(run), object: nil)
        thread.start()
    }
    
    // 分离出一条子线程，缺点是拿不到线程对象，无法对线程进一步自定义设置
    @IBAction func detachNewThread(_ sender: UIButton) {
        print(type(of: self), #function, Thread.current)
        if #available(iOS 10.0, *) {
            Thread.detachNewThreadSelector(#selector(run), toTarget: self, with: nil)
        }
    }
    
    // 方式三：缺点是拿不到线程对象，无法对线程进一步自定义设置
    @IBAction func newThreadByPerformSelector(_ sender: UIButton) {
        print(type(of: self), #function, Thread.current)
        self.performSelector(inBackground: #selector(run), with: nil)
    }
    
    @objc func run() {
        print(type(of: self), #function, Thread.current)
    }
    
    //MARK: - 拿到线程对象，设置线程的属性
    /*
     * 因为通过方式一创建子线程可以拿到线程对象，从而我们可以对该线程对象进行进一步的设置
     */
    @IBAction func setThreadAttribute(_ sender: UIButton) {
        
        let thread1 = Thread(target: self, selector: #selector(test), object: nil)
        let thread2 = Thread(target: self, selector: #selector(test), object: nil)
        let thread3 = Thread(target: self, selector: #selector(test), object: nil)
        
        // 设置线程的名称
        thread1.name = "thread1"
        thread2.name = "thread2"
        thread3.name = "thread3"
        
        // 设置线程的优先级(0~1, 默认为0.5)
        thread1.threadPriority = 1
        thread3.threadPriority = 0.01
        
        thread1.start()
        thread2.start()
        thread3.start()
    }
    
    @objc func test() {
        for i in 0...300 {
            print(i, type(of: self), #function, Thread.current)
        }
    }
    
    //MARK: - 测试线程的生命周期
    /*
     * Thread创建的子线程的生命周期：当子线程执行完任务后就被销毁
     */
    @IBAction func threadLifeCycle(_ sender: UIButton) {
        
        let thread = SFThread(target: self, selector: #selector(run), object: nil)
        thread.start()
    }
    
    //MARK: - 控制线程的状态
    /*
     * 让线程对象阻塞，到指定时间继续执行
     */
    @IBAction func sleepThread(_ sender: UIButton) {
        let thread = Thread(target: self, selector: #selector(sleep), object: nil)
        thread.start()
    }
    
    @objc func sleep() {
        print("start")
        Thread.sleep(forTimeInterval: 2)
        Thread.sleep(until: Date(timeInterval: 3, since: Date()))
        print("end")
    }
    
    /*
     * 当达到某个条件，让线程对象强制退出，通过调用：Thread.exit()
     */
    @IBAction func exitThread(_ sender: UIButton) {
        let thread = SFThread(target: self, selector: #selector(exit), object: nil)
        thread.start()
    }
    
    @objc func exit() {
        print("start")
        for i in 0...3000000000 {
            if i == 3000000000 {
                // 线程对象强制退出
                Thread.exit()
            }
        }
    }
    
    lazy var thread0: Thread = Thread(target: self, selector: #selector(sellTicket), object: nil)
    lazy var thread1: Thread = Thread(target: self, selector: #selector(sellTicket), object: nil)
    lazy var thread2: Thread = Thread(target: self, selector: #selector(sellTicket), object: nil)
    
    var totalTicketCount: Int = 100
    
    //MARK: - 多条线程时防止出现安全隐患给线程加锁
    /*
     * Swift 通过NSLock实现加锁
     * OC 通过@synchronized(self) { 需要被加锁的代码 }
     * self是加锁的对象，该对象必须保证“全局”且“唯一”（保证不被重复加锁，重复加锁无意义）
     */
    @IBAction func lockThread(_ sender: UIButton) {
        
        thread0.name = "售票员0"
        thread1.name = "售票员1"
        thread2.name = "售票员2"
        
        thread0.start()
        thread1.start()
        thread2.start()
    }
    
    var lock: NSLock = NSLock()
    
    @objc func sellTicket() {
        
        while true {
            lock.lock()
            if totalTicketCount > 0 {
                totalTicketCount -= 1
                print("\(String(describing: Thread.current.name))卖了一张票，还剩\(totalTicketCount)张")
            } else {
                print("\(String(describing: Thread.current.name))发现票卖完了")
                break
            }
            lock.unlock()
        }
    }
    
    //MARK: - 自定义thread
    /*
     * 在自定义的线程类中重写main方法，在main方法中封装任务，可以更好的分离复用代码
     */
    @IBAction func customThread(_ sender: UIButton) {
        
        let thread = SFCustomThread()
        thread.start()
    }
    
    //MARK: - 实例
    @IBOutlet weak var imageView: UIImageView!
    
    @available(iOS 10.0, *)
    @IBAction func downloadImageAndUpdateUI(_ sender: UIButton) {
        Thread.detachNewThread {
            let url = URL(string: "http://www.51edu.com/uploadfile/20160414/1460621542103119.png")
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            /*
             * waitUntilDone: true代表等待self.update方法执行完毕再继续执行下一行代码
             * waitUntilDone: true代表不等待self.update方法执行完毕，直接执行下一行代码
             */
            self.performSelector(onMainThread: #selector(self.update), with: image, waitUntilDone: true)
            print(type(of: self), #function)
            // self.perform(<#T##aSelector: Selector##Selector#>, on: <#T##Thread#>, with: <#T##Any?#>, waitUntilDone: <#T##Bool#>)
        }
    }
    
    @objc func update(image: UIImage) {
        print(type(of: self), #function)
        imageView.image = image
    }
}
