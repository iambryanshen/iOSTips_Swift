//
//  SFDrawTextView.swift
//  iOSTips
//
//  Created by brian on 2018/3/12.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDrawTextView: UIView {

    override func draw(_ rect: CGRect) {
        
        let text: NSString = "hello world"
        
        var attributes = [NSAttributedStringKey: Any]()
        attributes[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 50)
        attributes[NSAttributedStringKey.strokeColor] = UIColor.green
        attributes[NSAttributedStringKey.strokeWidth] = 5

        text.draw(at: CGPoint.zero, withAttributes: attributes)
        
        
    }
}
