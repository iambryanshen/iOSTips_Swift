//
//  SFPlistViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 只能存储特定类的数据：
 NSArray;
 NSMutableArray;
 NSDictionary;
 NSMutableDictionary;
 NSData;
 NSMutableData;
 NSString;
 NSMutableString;
 NSNumber;
 NSDate;
 */

class SFPlistViewController: UIViewController {
    
    lazy var plistPath: String = {
        guard let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {return ""}
        let plistPath = documentPath.appending("/demo.plist")
        return plistPath
    }()
    
    @IBOutlet weak var plistPathLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func getPlistPath(_ sender: UIButton) {
        plistPathLabel.text = plistPath
    }
    
    @IBAction func saveDataToPlist(_ sender: UIButton) {
        let stringArray : NSArray = ["hello", "brian", "bryant"]
        stringArray.write(toFile: plistPath, atomically: true)
    }
    
    @IBAction func getDataFromPlist(_ sender: UIButton) {
        guard let resultArray: [String] = NSArray(contentsOfFile: plistPath) as? [String] else {return}
        dataLabel.text = resultArray[0] + " " +  resultArray[1] + resultArray[2]
    }
}
