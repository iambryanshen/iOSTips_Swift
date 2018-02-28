//
//  SFDefaultStatusViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/25.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFDefaultStatusViewController: UIViewController, DefaultStatusProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let status = Status(title: "title", description: "description", image: UIImage(named: "image.png")!, action: {
            self.hide()
        })
        
        show(status: status)
    }
    
    // 在UIView上显示缺省图
    func test1() {
        let testView = SFDefaultStatusView(frame: self.view.bounds)
        view.addSubview(testView)
    }
}
