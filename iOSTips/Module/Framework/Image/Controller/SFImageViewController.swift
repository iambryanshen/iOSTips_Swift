//
//  SFImageViewController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/17.
//  Copyright © 2017年 brian. All rights reserved.
//

/*
 二级缓存结构：
 1. 在显示图片之前，先检查有没有内存缓存
 2. 如果有内存缓存，直接使用
 3. 如果没有内存缓存，去检查是否有磁盘缓存
 4. 如果有磁盘缓存，直接使用，同时保存一份到内存中
 5. 如果没有磁盘缓存，检查是否有缓存下载操作
 6. 如果有缓存下载操作，什么也不做，否则下载图片并显示出来，同时分别保存一份到内存中和磁盘中，并缓存下载操作到内存缓存中
 */

import UIKit


class SFImageViewController: UIViewController {
    
    lazy var datasourceArray: [ImageModel] = {
        let path = Bundle.main.path(forResource: "apps", ofType: "plist") ?? ""
        let datasourceArray = NSArray(contentsOfFile: path) as! [[String: String]]
        var tempDatasourceArray = [ImageModel]()
        for dict in datasourceArray {
            let imageModel = ImageModel(dict: dict)
            tempDatasourceArray.append(imageModel)
        }
        return tempDatasourceArray
    }()
    var tableView: UITableView?
    
    // 在内存中缓存下载的图片
//    lazy var imageDict: [String: UIImage] = [String: UIImage]()
    lazy var cache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.countLimit = 5
        cache.totalCostLimit = 10   // 设置该属性时，要配合方法open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int)才有效
        cache.delegate = self
        return cache
    }()
    
    // 在内存中缓存下载操作
    lazy var operations: [NSString: BlockOperation] = [NSString: BlockOperation]()
    lazy var queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
}

extension SFImageViewController {
    func setupSubviews() {
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        self.tableView = tableView
        view.addSubview(tableView)
    }
}

extension SFImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        
        let model = datasourceArray[indexPath.row]
        
        guard let icon = model.icon as NSString? else {
            return ImageTableViewCell()
        }
        
        // 1. 在显示图片之前，先检查有没有内存缓存
        let imageData = cache.object(forKey: icon)
        // 2. 如果有内存缓存，直接使用
        if let imageData = imageData as Data? {
            print("内存缓存\(indexPath)")
            cell.iconImageView.image = UIImage(data: imageData)
        // 3. 如果没有内存缓存，去检查是否有磁盘缓存
        } else {
            let fileName = icon.components(separatedBy: "/").last ?? ""
            let fullPath = cachePath + "/\(fileName)"
            let fullPathURL = URL(fileURLWithPath: fullPath, isDirectory: true)
            // 4. 如果有磁盘缓存，直接使用，同时保存一份到内存中
            if let imageData = NSData(contentsOf: fullPathURL) {
                cell.iconImageView?.image = UIImage(data: imageData as Data)
                cache.setObject(imageData, forKey: icon, cost: 1)
            } else {
                // 5. 如果没有磁盘缓存，使用占位图片，并检查内存中有没有缓存下载操作
                cell.iconImageView?.image = UIImage(named: "liuxinjia.JPG")
                if let operation = operations[icon] {
                    print("下载中-\(indexPath)-\(operation)")
                    // 6. 如果没有缓存下载操作，创建下载操作下载图片并显示出来，同时分别保存一份到内存中和磁盘中
                } else {
                    if let imageURL = URL(string: icon as String) {
                        let operation = BlockOperation(block: {
                            if let imageData = NSData(contentsOf: imageURL) {
                                // 7. 保存下载的图片到内存缓存和磁盘缓存
                                self.cache.setObject(imageData, forKey: icon, cost: 1)
                                let fileName = icon.components(separatedBy: "/").last ?? ""
                                let fullPath = cachePath + "/\(fileName)"
                                let fullPathURL = URL(fileURLWithPath: fullPath, isDirectory: true)
                                imageData.write(to: fullPathURL, atomically: true)
                            }
                            // 8. 回到主线程刷新UI
                            OperationQueue.main.addOperation {
                                tableView.reloadRows(at: [indexPath], with: .bottom)
                            }
                        })
                        // 9. 添加下载操作到队列中，开始下载
                        queue.addOperation(operation)
                        // 10. 缓存下载操作到内存中
                        operations.updateValue(operation, forKey: icon)
                    }
                }
            }
        }
        cell.nameLabel.text = datasourceArray[indexPath.row].name
        cell.downloadLabel.text = datasourceArray[indexPath.row].download
        return cell
    }
}

extension SFImageViewController: NSCacheDelegate {
    // 回收内存时调用
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        print("回收内存")
    }
}
