//
//  CountryModel.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

@objcMembers
class CountryModel: NSObject {
    
    var name: String?
    var icon: String?
    
    // 新增属性，逻辑分离。model负责处理数据
    var flagImage: UIImage? {
        get {
            guard let iconString = icon else {
                return UIImage()
            }
            return UIImage(named: iconString)
        }
    }
    
    static func countryModelWithDict(dict: [String: String]) -> CountryModel {
        let countryModel = CountryModel()
        countryModel.setValuesForKeys(dict)
        return countryModel
    }
}
