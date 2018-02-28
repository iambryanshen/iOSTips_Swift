//
//  SFAppJumpViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/2.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFAppJumpViewController: UIViewController {
    
    @IBAction func makeACall(_ sender: UIButton) {
        openURL("tel://10086")
    }
    @IBAction func sendMessage(_ sender: UIButton) {
        openURL("sms://10086")
    }
    @IBAction func openSetting(_ sender: UIButton) {
        openURL(nil)
    }
    @IBAction func openBluetooth(_ sender: UIButton) {
        openURL(nil)
    }
    @IBAction func openWifi(_ sender: UIButton) {
        openURL(nil)
    }
    
    //封装打开系统应用的方法,传入url的字符串即可
    func openURL(_ url: String?) {
        
        guard let tempUrl = url, let url = URL(string: tempUrl) else {
            if #available(iOS 10.0, *) {
                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { (granted) in
                            if granted {
                                print("jump success")
                            } else {
                                print("jump failure")
                            }
                        })
                    } else {
                        print("url不可跳转")
                    }
                }
            } else {
                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
            }
            return
        }

        // 打电话、发短信
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (granted) in
                    print("打电话or发短信success")
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
