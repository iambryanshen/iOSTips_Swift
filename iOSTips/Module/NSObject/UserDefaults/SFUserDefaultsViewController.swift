//
//  SFUserDefaultsViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 存储轻量级的全局需要的配置信息，一般能保证下次启动App可以快速恢复这些信息 
 */

class SFUserDefaultsViewController: UIViewController {
    
    lazy var userDefaults: UserDefaults = {
        let userDefaults: UserDefaults = UserDefaults.standard
        return userDefaults
    }()
    
    @IBOutlet weak var preferencePathLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func getPreferencePath(_ sender: UIButton) {
        guard let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first else {
            return
        }
        let preferencePath = libraryPath + "/Preferences"
        preferencePathLabel.text = preferencePath
    }
    
    @IBAction func saveDataToPreference(_ sender: UIButton) {
        userDefaults.set(true, forKey: "BoolKey")
        userDefaults.set("http:www.baidu.com", forKey: "UrlKey")
        userDefaults.set(23, forKey: "DoubleKey")
        userDefaults.set("http:shenzhengfang.com", forKey: "AnyKey")
        // Because this method is automatically invoked at periodic intervals, use this method only if you cannot wait for the automatic synchronization (for example, if your application is about to exit) or if you want to update the user defaults to what is on disk even though you have not made any changes.
        userDefaults.synchronize()
    }

    @IBAction func getDataFromPreference(_ sender: UIButton) {
        let boolValue = userDefaults.bool(forKey: "BoolKey")
        let stringValue = userDefaults.string(forKey: "UrlKey")
        let doubleValue = userDefaults.double(forKey: "DoubleKey")
        dataLabel.text = "\(boolValue, stringValue, doubleValue)"
        print(boolValue, stringValue, doubleValue)
    }
}
