//
//  SFFunctionQueueViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/26.
//  Copyright © 2018年 brian. All rights reserved.
//

/*
 * 并发队列：可以让多个任务并发（同时）执行
 *      > 支持自动开启多个线程执行多个任务
 *      > 并发功能只有在异步函数下才有效（同步函数不支持开新线程的能力，无从谈起并发）
 *
 * 串行队列：任务一个接着一个执行（一个任务执行完毕后才能执行下一个任务）
 *
 * 同步函数：
 *      > 只能在当前线程执行任务，不具备开启新线程的能力
 *      > 同步执行任务，必须等当前任务执行完毕，才会执行下一个任务
 *
 * 异步函数：
 *      > 可以在新的线程中执行任务，具备开启新线程的能力
 *      > 必须等当前任务执行完毕，就能执行后面的任务
 *
 * 全局并发队列：
 *      > 在使用上等于创建的并发队列。区别是系统自动创建，只需获取就可以，无需创建
 *      > 在iOS6.0之前，需要手动创建，手动释放
 *      > 栅栏函数不能使用全部并发队列，只能手动创建并发队列（苹果官方暂未给出具体原因！！！）
 *
 * 主队列：是一种GCD自带的特殊的串行队列，放到主队列中的任务都必须在主线程中执行
 *      > 主队列 & 异步函数不会阻塞主线程（异步函数执行任务，不需要当前任务执行完成，就会继续执行下一个任务）
 *      > 主队列 & 同步函数会阻塞主线程（）
 * 总结：
 *      同步函数：
 *              + 并发队列：不会开启新线程，所有任务在当前线程串行执行
 *              + 串行队列：不会开启新线程，所有任务在当前线程串行执行
 *              + 主队列（特殊的串行队列）：所有任务在主线程会发生死锁。
 *      异步函数：
 *              + 并发队列：会开启N条线程，所有的任务在子线程中并发执行（N条 != 任务数）
 *              + 串行队列：开启一条子线程，所有的任务在开启的这条子线程中串行执行
 *              + 主队列（特殊的串行队列）：不会开子线程，所有的任务在主线程中串行执行
 * > 会开线程的情况：①：异步函数，②不能是主队列
 *              （如果是串行队列开启一条线程，如果是并发队列，开启多条线程）
 * > 不会开线程的情况：①：如果是同步函数，一定不会开线程。②：如果是异步函数，如果又是主队列同样不开线程
 */

import UIKit

class SFFunctionQueueViewController: UIViewController {
    
    /*
     * 并发队列 & 异步函数：开启多条线程，同时执行多条任务
     *      注意：开几条线程，不是由任务的数量决定的，是GCD内部决定的。（可能1000个任务只开20条线程）
     */
    @IBAction func concurrentAsync(_ sender: UIButton) {
        let queue = DispatchQueue(label: "com.brian.www", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        queue.async {
            print("任务1----", Thread.current)
        }
        queue.async {
            print("任务2----", Thread.current)
        }
        queue.async {
            print("任务3----", Thread.current)
        }
    }
    
    /*
     * 并发队列 & 同步函数：在当前线程中串行执行
     *      > 注意：
     *          1. 是在"当前线程"中串行执行，而不是在"主线程"中串行执行
     *          2. 如果以下代码块在"子线程(number = 2)"中执行，那么"当前线程"就是对应"子线程(number = 2)"
     *      > 同步函数不具备开启子线程的能力
     *      > 并发队列同步执行需要开启多条子线程，无法开启子线程，所以只能在"当前线程"中串行执行
     */
    @IBAction func concurrentSync(_ sender: UIButton) {
        let queue = DispatchQueue(label: "com.brian.www", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        queue.sync {
            print("任务1----", Thread.current)
        }
        queue.sync {
            print("任务2----", Thread.current)
        }
        queue.sync {
            print("任务3----", Thread.current)
        }
    }
    
    /*
     * 串行队列 & 异步函数：开启 "一条" 子线程，所有的任务在子线程中串行执行
     *      > 异步函数具备开子线程的能力
     *      > 任务只能串行执行，所有没有必要开启多条线程，开启一条子线程足矣
     */
    @IBAction func serialAsync(_ sender: UIButton) {

        let queue = DispatchQueue(label: "com.brian.www")
        queue.async {
            print("任务1----", Thread.current)
        }
        queue.async {
            print("任务2----", Thread.current)
        }
        queue.async {
            print("任务3----", Thread.current)
        }
    }
    
    
    /*
     * 串行队列 & 同步函数
     *      > 同步函数只能在当前线程执行任务，不具备开启新线程的能力
     *      > 任务只能串行执行，所以任务只能在当前线程执行，当前线程是主线程就在主线程执行，当前线程是子线程就在子线程中执行
     */
    @IBAction func serialSync(_ sender: UIButton) {
        Thread.detachNewThread {
            let queue = DispatchQueue(label: "com.brian.www")
            queue.sync {
                print("任务1----", Thread.current)
            }
            queue.sync {
                print("任务2----", Thread.current)
            }
            queue.sync {
                print("任务3----", Thread.current)
            }
        }
    }
    
    /*
     * 全局并发队列在使用上，等等与普通创建的并发队列。区别是无法手动创建，只需获取使用就可以
     */
    @IBAction func globalQueue(_ sender: UIButton) {
        
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            print("任务1----", Thread.current)
        }
        globalQueue.async {
            print("任务2----", Thread.current)
        }
        globalQueue.async {
            print("任务3----", Thread.current)
        }
    }
    
    /*
     * 主队列 & 异步函数
     *      > 虽然异步函数支持开启子线程，但当前情况（主队列的任务都会在主线程中执行）不会开启子线程，任务都在主线程中串行执行
     *      > 注意：为什么任务和当前mainQueueAsync都在主线程执行，却不会阻塞主线程
     *          1. mainQueueAsync在主线程中执行，print("任务1----", Thread.current)也在主线程中执行
     *          2. 执行到print("任务1----", Thread.current)的时候，主线程的当前任务mainQueueAsync没有执行完成
     *          3. 主队列中的任务print("任务1----", Thread.current)会需要等待主线程空闲才会执行
     *          4. 因为是异步函数异步执行任务，当前任务print("任务1----", Thread.current)虽然没有执行完，但是会继续执行下一个任务。
     *          5. 这样在mainQueueAsync执行完成之前，所有的任务都被“打包”放到主队列中等待执行，等待主线程空闲就会来执行主队列中的任务
     */
    @IBAction func mainQueueAsync(_ sender: UIButton) {
        
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            print("任务1----", Thread.current)
        }
        mainQueue.async {
            print("任务2----", Thread.current)
        }
        mainQueue.async {
            print("任务3----", Thread.current)
        }
    }
    
    /*
     * 主队列 & 同步函数：
     *      > 执行任务逻辑：
     *          当主队列中有任务时，主队列会安排主线程来执行任务，但在调度之前会先检查主线程的状态（是否在已经正在执行任务），如果主线程正在执行任务，就会停止调度，直到主线程空闲为止开始执行主队列中的任务
     *      > 同步函数不支持开启子线程，又因为主队列的任务都在主线程执行。理所当然，当前任务都在主线程中执行
     *      > 注意：如果把任务放到主线程中执行，会阻塞主线程，为什么？
     *          1. 因为mainQueueSync在主线程中串行执行
     *          2. 执行到print("任务1----", Thread.current)的时候（属于主队列中的任务），会去检查主线程的状态，主线程中的当前任务mainQueueAsync没有执行完成，这样主队列就会停止调度，等待主队列空闲再开始执行主队列中的任务
     *          3. 因为是同步函数，必须等当前任务执行完才会执行下一个任务，所以mainQueueAsync会卡在print("任务1----", Thread.current)，永远执行不完，因为mainQueueAsync执行不会，主队列中的任务也永远不会开始执行，导致主线程阻塞
     *          4. 所以如果是主队列 & 同步函数的组合，任务1、2、3需要放到子线程中执行
     *              （主线程执行点击事件，子线程执行任务）保证不会阻塞线程
     */
    @IBAction func mainQueueSync(_ sender: UIButton) {
        
        /* 这种情况会阻塞主线程
         let mainQueue = DispatchQueue.main
         
         mainQueue.sync {
            print("任务1----", Thread.current)
         }
         
         mainQueue.sync {
            print("任务2----", Thread.current)
         }
         
         mainQueue.sync {
            print("任务3----", Thread.current)
         }
         */
        
        Thread.detachNewThread {
            
            print("在子线程中执行，主线程空闲", Thread.current)
            
            let mainQueue = DispatchQueue.main
            
            mainQueue.sync {
                print("任务1----", Thread.current)
            }
            
            mainQueue.sync {
                print("任务2----", Thread.current)
            }
            
            mainQueue.sync {
                print("任务3----", Thread.current)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func threadCommunication(_ sender: UIButton) {
        DispatchQueue.global().async {
            // 子线程下载图片
            print(Thread.current)
            let url = URL(string: "http://article.fd.zol-img.com.cn/t_s500x2000/g4/M08/04/06/Cg-4WlPoSQaIJMNHAAFQxnn-qSoAAQZGQCqggkAAVDe827.jpg")!
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                // 主线程更新UI
                print(Thread.current)
                self.imageView.image = image
            }
        }
    }
    // swift3.0之后gcd一次性代码废弃！！！
    @IBAction func once(_ sender: UIButton) {
        
    }
    @IBAction func delayExecution(_ sender: UIButton) {
     
        /*
         * 队列：
         *      > 主队列就在主线程中执行（不论同步异步函数，只要是朱队列，任务就在主线程中执行）
         *      > 串行队列 + 同步函数：主线程中执行
         *      > 串行队列 + 异步函数：开且仅开一条子线程中执行
         *      > 并发队列 + 同步函数：在主线程中执行
         *      > 并发队列 + 异步函数：在子线程中执行（可开多条线程）
         * 执行时间
         * 执行任务
         * 实现原理：先等延迟时间（两秒），然后添加任务到队列中执行
         */
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            print(Thread.current)
        }
    }
}
