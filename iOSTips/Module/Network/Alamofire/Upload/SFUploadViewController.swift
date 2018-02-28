//
//  SFUploadViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/22.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Alamofire

class SFUploadViewController: UIViewController {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func startUpload(_ sender: UIButton) {
        
//        var imageData = Data()
//        if let image = UIImage(named: "icon.JPG") {
//            if let tempImage = UIImageJPEGRepresentation(image, 1) {
//                imageData = tempImage
//            } else {
//                print("图片压缩失败")
//            }
//        } else {
//            print("图片读取失败")
//        }
//
//        let url = URL(string: "http://120.25.226.186:32812/upload")!
//        Alamofire.upload(imageData, to: url).responseJSON { (response) in
//            print(response)
//        }
    }
}
