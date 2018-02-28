//
//  LoadNibProtocol.swift
//  iOSTips
//
//  Created by brian on 2018/1/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

protocol LoadNibProtocol {}

extension LoadNibProtocol where Self: UIView {
    static func loadFromNib(name: String? = nil) -> Self {
        let name = name ?? "\(self)"
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! Self
    }
}
