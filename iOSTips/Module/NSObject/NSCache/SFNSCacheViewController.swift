//
//  SFNSCacheViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFNSCacheViewController: UIViewController {
    
    fileprivate lazy var cache: NSCache<NSString, NSString> = {
        let cache = NSCache<NSString, NSString>()
//        cache.countLimit = 6
        cache.totalCostLimit = 8 // 需要配合存储方法一起使用：open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int)
        cache.delegate = self
        return cache
    }()

    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        for index in 0..<10 {
//            cache.setObject("\(index)" as NSString, forKey: "\(index)" as NSString)
            cache.setObject("\(index)" as NSString, forKey: "\(index)" as NSString, cost: 2)
        }
        
        var tempString : String = ""
        for index in 0..<10 {
            let string = cache.object(forKey: "\(index)" as NSString) ?? ""
            tempString.append(string as String)
        }
        contentLabel.text = tempString
    }
}

//MARK: - NSCacheDelegate
extension SFNSCacheViewController: NSCacheDelegate {
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        print("回收内存")
    }
}
