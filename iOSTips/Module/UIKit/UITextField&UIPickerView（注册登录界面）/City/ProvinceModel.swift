//
//  ProvinceModel.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

@objcMembers
class ProvinceModel: NSObject {

    var cities: NSArray?
    var name: String?
    
    static func provinceModelWithDict(dict: [String: Any]) -> ProvinceModel {
        
        let provinceModel = ProvinceModel()
        provinceModel.setValuesForKeys(dict)
        return provinceModel
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
