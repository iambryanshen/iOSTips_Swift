//
//  SFActivityIndicatorViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/10.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFActivityIndicatorViewController: UIViewController {
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = self.view.center
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        view.addSubview(activityIndicatorView)
    }
}

extension SFActivityIndicatorViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if activityIndicatorView.isAnimating {
            activityIndicatorView.stopAnimating()
        } else {
            activityIndicatorView.startAnimating()
        }
    }
}
