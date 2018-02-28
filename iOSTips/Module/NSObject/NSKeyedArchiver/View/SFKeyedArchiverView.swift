//
//  SFKeyedArchiverView.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFKeyedArchiverView: UIView {

    // 解析MyView的nib文件完毕调用
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print(type(of: self), #function, "解析MyView的nib文件完毕调用")
    }

    // 开始解析MyView的nib文件时调用
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        print(type(of: self), #function, "开始解析MyView的nib文件时调用")
    }
}
