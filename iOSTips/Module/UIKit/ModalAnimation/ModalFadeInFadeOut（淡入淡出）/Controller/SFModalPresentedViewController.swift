//
//  SFModalPresentedViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/15.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFModalPresentedViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 50))
        button.center = view.center
        button.setTitle("dismiss", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(dismissCurrentVC), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green
        view.addSubview(button)
    }
    
    @objc func dismissCurrentVC() {
        dismiss(animated: true) {
            print("dismiss success")
        }
    }
}
