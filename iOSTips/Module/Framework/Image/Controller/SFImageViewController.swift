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
 5. 如果没有磁盘缓存，下载图片并显示出来，同时分别保存一份到内存中和磁盘中
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
    lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 5
        cache.totalCostLimit = 10   // 设置该属性时，要配合方法open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int)才有效
        cache.delegate = self
        return cache
    }()
    
    // 在内存中缓存下载操作
    lazy var operations: [String: BlockOperation] = [String: BlockOperation]()
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
        
        // 1. 在显示图片之前，先检查有没有内存缓存
        guard let icon = model.icon else {
            return ImageTableViewCell()
        }
        let image = cache.object(forKey: icon as NSString)
//        let image = imageDict[model.icon ?? ""]
        // 2. 如果有内存缓存，直接使用
        if let image = image {
            print("内存缓存\(indexPath)")
            cell.iconImageView.image = image
            
        // 3. 如果没有内存缓存，去检查是否有磁盘缓存
        } else {
            
            var imageData = Data()
            do {
                let fileName = model.icon?.components(separatedBy: "/").last ?? ""
                let fullPath = cachePath + "/\(fileName)"
                let fullPathURL = URL(fileURLWithPath: fullPath, isDirectory: true)
                imageData = try Data(contentsOf: fullPathURL)
            } catch {
                print("从磁盘缓存读取图片失败！")
            }
            let image = UIImage(data: imageData)
            
            // 4. 如果有磁盘缓存，直接使用，同时保存一份到内存中
            if let image = image {
                print("磁盘缓存\(indexPath)")
                // 1. 使用磁盘缓存
                cell.iconImageView?.image = image
                // 2. 保存一份到内存缓存中
                cache.setObject(image, forKey: icon as NSString, cost: 1)
//                imageDict.updateValue(image, forKey: model.icon ?? "")
                
            // 5. 如果没有磁盘缓存，下载图片并显示出来，同时分别保存一份到内存中和磁盘中
            } else {
                cell.iconImageView?.image = UIImage(named: "liuxinjia.JPG")
                // 1. 下载图片
                if let imageURL = URL(string: model.icon ?? "") {
                    // 判断是否正在下载
                    if let operation = operations[model.icon ?? ""] {
                        print("下载中-\(indexPath)-\(operation)")
                    } else {
                        
                        // 子线程下载图片
                        let operation = BlockOperation(block: {
                            do {
                                let imageData = try Data(contentsOf: imageURL)
                                if let image = UIImage(data: imageData) {
                                    // 2. 保存一份到内存缓存中
//                                    self.imageDict.updateValue(image, forKey: model.icon ?? "")
                                    self.cache.setObject(image, forKey: icon as NSString, cost: 1)
                                    // 3. 保存一份到磁盘缓存中
                                    do {
                                        let fileName = model.icon?.components(separatedBy: "/").last ?? ""
                                        let fullPath = cachePath + "/\(fileName)"
                                        let fullPathURL = URL(fileURLWithPath: fullPath, isDirectory: true)
                                        try imageData.write(to: fullPathURL)
                                    } catch {
                                        print("保存图片到磁盘缓存失败")
                                    }
                                }
                                print("下载图片\(indexPath)")
                            } catch {
                                print("下载图片失败")
                            }
                            // 回到主线程刷新UI
                            OperationQueue.main.addOperation {
                                tableView.reloadRows(at: [indexPath], with: .bottom)
                            }
                        })
                        queue.addOperation(operation)
                        // 保存下载操作到内存中
                        operations.updateValue(operation, forKey: model.icon ?? "")
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
