//
//  SFSystemSettingViewController.swift
//  iOSTips
//
//  Created by Brian on 2018/2/14.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import UserNotifications

class SFSystemSettingViewController: UIViewController {
    
    @IBAction func setIconNumber(_ sender: UIButton) {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
                
                if error == nil {
                    print("request authorization succeeded!")
                } else {
                    print("request authorization failed!")
                    return
                }
                
                if granted {
                    print("获取全部授权")
                } else {
                    print("有一个或多个授权被拒绝")
                }
            })
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        // set to 0 to hide. default is 0.
        // In iOS 8.0 and later, your application must register for user notifications using -[UIApplication registerUserNotificationSettings:] before being able to set the icon badge.
        UIApplication.shared.applicationIconBadgeNumber = 10
    }
    @IBAction func setNetworkStatus(_ sender: UIButton) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = !UIApplication.shared.isNetworkActivityIndicatorVisible
    }
    @IBAction func setStatusBar(_ sender: UIButton) {
        
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.isStatusBarHidden = false
    }
}
