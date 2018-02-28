//
//  ImageModel.swift
//  iOSTips
//
//  Created by Brian on 2017/12/17.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

@objcMembers
class ImageModel: NSObject {
    
    var name: String?
    var download: String?
    var icon: String?
    
    init(dict: [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
