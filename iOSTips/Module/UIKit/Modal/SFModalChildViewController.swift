//
//  SFModalChildViewController.swift
//  iOSLearning
//
//  Created by brian on 2018/1/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFModalChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        setupSubviews()
    }
}

extension SFModalChildViewController {
    
    func setupSubviews() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        button.center = self.view.center
        view.addSubview(button)
        button.setTitle("dismiss", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(modalVC), for: .touchUpInside)
    }
    
    @objc func modalVC() {
        
        self.dismiss(animated: true) {
            print("dismiss vc success")
        }
    }
}
