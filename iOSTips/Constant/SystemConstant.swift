//
//  SystemConstant.swift
//  iOSTips
//
//  Created by brian on 2017/12/18.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let kNavigationBarHeight: CGFloat = 44

let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
let downloadVideoListPath = cachePath + "/downloadList.plist"
