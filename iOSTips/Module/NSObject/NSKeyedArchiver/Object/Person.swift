//
//  Person.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    var name: String?
    var age: Int?
    var dog: Dog?
    
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(dog, forKey: "dog")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.age = aDecoder.decodeObject(forKey: "age") as? Int
        self.dog = aDecoder.decodeObject(forKey: "dog") as? Dog
    }
}
