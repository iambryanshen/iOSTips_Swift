//
//  Dog.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class Dog: NSObject, NSCoding {

    var dogName: String?
    
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dogName, forKey: "dogName")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dogName = aDecoder.decodeObject(forKey: "dogName") as? String
    }
}
