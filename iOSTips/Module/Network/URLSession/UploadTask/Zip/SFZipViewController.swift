//
//  SFZipViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Zip

class SFZipViewController: UIViewController {
    
    var zipPathURL: URL?
    
    @IBAction func zip(_ sender: UIButton) {
        
        let file1 = Bundle.main.path(forResource: "1", ofType: "JPG")
        let file2 = Bundle.main.path(forResource: "2", ofType: "JPG")
        let url1 = URL(string: file1!)
        let url2 = URL(string: file2!)
        let paths: [URL] = [url1!, url2!]
        // 返回的是压缩后的压缩文件存储的路径
        zipPathURL = try? Zip.quickZipFiles(paths, fileName: "Her")
        print(zipPathURL)
    }
    
    @IBAction func unZip(_ sender: UIButton) {
        if let zipPathURL = zipPathURL {
            // 返回的是解压后的文件存储的路径
            let unZipPath = try? Zip.quickUnzipFile(zipPathURL)
            print(unZipPath)
        } else {
            print("请先压缩，否则没有压缩文件供解压")
        }
    }
}
