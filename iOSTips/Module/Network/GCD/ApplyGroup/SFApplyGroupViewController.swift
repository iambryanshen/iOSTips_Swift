//
//  SFApplyGroupViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/27.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 * 队列组：
 *      > public func notify(queue: DispatchQueue, work: DispatchWorkItem)拦截通知，当所有任务都执行完成后，执行notify中的代码
 *      > public func notify(queue: DispatchQueue, work: DispatchWorkItem)中的参数queue和队列组中的执行的任务的队列没有关系，该参数队列是notify函数中的任务所在的队列
 *      > public func notify(queue: DispatchQueue, work: DispatchWorkItem)内部异步执行
 */

class SFApplyGroupViewController: UIViewController {

    // GCD的循环遍历：并发多线程遍历，更高效
    @IBAction func apply(_ sender: UIButton) {
        
        /*
         * 会开启多条子线程和主线程一起并发的执行任务
         * Swift3以后默认就是并发队列。如果swift3以前可以指定队列的时候，如果使用串行队列和for循环遍历没有区别（串行遍历）
         */
        DispatchQueue.concurrentPerform(iterations: 10) { (i) in
            print(i, Thread.current)
        }
    }
    
    /*
     * 栅栏函数的使用
     * 注意：栅栏函数的队列不可以使用全局并发队列，使用全部并发队列，栅栏函数无效
     */
    
    @IBAction func barrier(_ sender: UIButton) {
        
        let concurrentQueue = DispatchQueue(label: "com.brian.www", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        
        concurrentQueue.async {
            print("1-------", Thread.current)
        }
        
        concurrentQueue.async {
            print("2-------", Thread.current)
        }
        
        let barrier = DispatchWorkItem(qos: DispatchQoS.default, flags: DispatchWorkItemFlags.barrier) {
            print("barrier-------", Thread.current)
        }
        
        concurrentQueue.async(execute: barrier)
        
        concurrentQueue.async {
            print("3-------", Thread.current)
        }
        
        concurrentQueue.async {
            print("4-------", Thread.current)
        }
    }
    
    /*
     * 队列组使用方法一（常用，省去写大量enter、leave）
     */
    @IBAction func queueGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        let queue0 = DispatchQueue(label: "com.brian.www.0", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        let queue1 = DispatchQueue(label: "com.brian.www.1", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        
        queue0.async(group: group, qos: DispatchQoS.default) {
            print("1--------", Thread.current)
        }
        queue0.async(group: group, qos: DispatchQoS.default) {
            print("2--------", Thread.current)
        }
        queue1.async(group: group, qos: DispatchQoS.default) {
            print("3--------", Thread.current)
        }
        queue1.async(group: group, qos: DispatchQoS.default) {
            print("4--------", Thread.current)
        }
        
        queue0.async(group: group, qos: DispatchQoS.default) {
            print("5--------", Thread.current)
        }
        queue0.async(group: group, qos: DispatchQoS.default) {
            print("6--------", Thread.current)
        }
        queue1.async(group: group, qos: DispatchQoS.default) {
            print("7--------", Thread.current)
        }
        queue1.async(group: group, qos: DispatchQoS.default) {
            print("8--------", Thread.current)
        }
        
        group.notify(queue: DispatchQueue.global()) {
            print("notify------", Thread.current)
        }
    }
    
    // 队列组使用方法二：
    @IBAction func queueGroup1(_ sender: UIButton) {
        let group = DispatchGroup()
        
        let queue0 = DispatchQueue(label: "com.brian.www.0", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        let queue1 = DispatchQueue(label: "com.brian.www.1", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
        
        group.enter()
        queue0.async {
            print("1--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue0.async {
            print("2--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue0.async {
            print("3--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue0.async {
            print("4--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue1.async {
            print("5--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue1.async {
            print("6--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue1.async {
            print("7--------", Thread.current)
            group.leave()
        }
        group.enter()
        queue1.async {
            print("8--------", Thread.current)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("notify------", Thread.current)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image1: UIImage?
    var image2: UIImage?
    
    @IBAction func downloadTwoImageAndSynthetic(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        let queue = DispatchQueue.global()
        
        // 下载图片一
        queue.async(group: group, qos: DispatchQoS.default) {
            
            let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519713717067&di=a33b3f62f254c7b6a120090ce5cfde00&imgtype=0&src=http%3A%2F%2Fimg0w.pconline.com.cn%2Fpconline%2F1309%2F11%2F3464151_31.jpg")!
            
            let data = try? Data(contentsOf: url)
            
            self.image1 = UIImage(data: data!)
            
            print("downloadimage1---", Thread.current)
        }
        
        // 下载图片二
        queue.async(group: group, qos: DispatchQoS.default) {
            let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519713717066&di=d096a0e499fe0735b77620a581dfa792&imgtype=0&src=http%3A%2F%2Fimg0w.pconline.com.cn%2Fpconline%2F1309%2F11%2F3464151_32.jpg")!
            
            let data = try? Data(contentsOf: url)
            
            self.image2 = UIImage(data: data!)
            
            print("downloadimage2---", Thread.current)
        }
        
        // 合成图片
        group.notify(queue: DispatchQueue.main) {
            
            UIGraphicsBeginImageContext(self.imageView.bounds.size)
            let rect1 = CGRect(x: 0, y: 0, width: self.imageView.bounds.width/2, height: self.imageView.bounds.height)
            self.image1?.draw(in: rect1)
            let rect2 = CGRect(x: self.imageView.bounds.width/2, y: 0, width: self.imageView.bounds.width/2, height: self.imageView.bounds.height)
            self.image2?.draw(in: rect2)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.imageView.image = image
            
            print("update UI---", Thread.current)
        }
    }
}
