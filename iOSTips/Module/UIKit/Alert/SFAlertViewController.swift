//
//  SFAlertViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/6.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func normalAlert(_ sender: UIButton) {
        
        let alertVC  = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            print("确定")
        }
        alertVC.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: {
            print("success")
        })
    }
}
