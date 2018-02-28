//
//  SFJSONExampleModel.swift
//  iOSTips
//
//  Created by brian on 2018/2/4.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFJSONExampleModel: NSObject {

    @objc var image: String?
    @objc var length: Int = 0
    @objc var name: String?
    @objc var url: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
