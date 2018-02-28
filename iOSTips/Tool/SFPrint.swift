//
//  SFPrint.swift
//  iOSTips
//
//  Created by brian on 2018/2/22.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

func dprint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        print(items, separator: separator, terminator: terminator)
    #endif
}
