//
//  SFDefaultStatusView.swift
//  iOSTips
//
//  Created by brian on 2017/12/25.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFDefaultStatusView: UIView, DefaultStatusProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let status = Status(title: "title", description: "description", image: UIImage(named: "image.png")) {
            self.hide()
        }
        
        show(status: status)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
