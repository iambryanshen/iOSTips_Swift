//
//  SFFatherChildVCViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFFatherChildVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationTitleView = Bundle.main.loadNibNamed("NavigationTitleView", owner: nil, options: nil)?.first as! NavigationTitleView
        navigationItem.titleView = navigationTitleView
        
        navigationTitleView.buttonClick = {[weak self] (tag) -> Void in
            guard let weakSelf = self else {return}
            print(tag)
            for subview in weakSelf.view.subviews {
                subview.removeFromSuperview()
            }
            
            let childVC = weakSelf.childViewControllers[tag]
            childVC.view.frame = weakSelf.view.bounds
            weakSelf.view.addSubview(childVC.view)
        }
        
        let oneVC = UIViewController()
        oneVC.view.backgroundColor = UIColor.red
        self.addChildViewController(oneVC)
        
        let twoVC = UIViewController()
        twoVC.view.backgroundColor = UIColor.blue
        self.addChildViewController(twoVC)
        
        navigationTitleView.buttonClick?(0)
    }
}
