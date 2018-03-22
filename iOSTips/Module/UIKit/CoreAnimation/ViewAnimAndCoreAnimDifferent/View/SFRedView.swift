//
//  SFRedView.swift
//  iOSTips
//
//  Created by brian on 2018/3/19.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFRedView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(type(of: self), #function)
    }
}
