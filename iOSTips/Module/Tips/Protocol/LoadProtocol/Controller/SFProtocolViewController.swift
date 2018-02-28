//
//  SFProtocolViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFProtocolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
}

extension SFProtocolViewController {
    func setupSubviews() {
        
        let protocolView = ProtocolView.loadFromNib()
        view.addSubview(protocolView)
        
        let protocolButton = SFProtocolButton.loadFromNib(name: "ProtocolButton")
        protocolButton.frame = CGRect(x: 0, y: 400, width: 200, height: 200)
        view.addSubview(protocolButton)
    }
}
