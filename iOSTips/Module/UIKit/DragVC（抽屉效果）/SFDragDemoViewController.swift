//
//  SFDragDemoViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/3.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDragDemoViewController: SFDragViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
}

extension SFDragDemoViewController {
    
    func setupSubviews() {
        
        let normalVC = SFDragNormalViewController()
        normalVC.view.frame = view.bounds
        self.mainView.addSubview(normalVC.view)
        self.addChildViewController(normalVC)
        
        let tableVC = SFDragTableViewController()
        tableVC.view.frame = view.bounds
        self.leftView.addSubview(tableVC.view)
        self.addChildViewController(tableVC)
        
        let layout = UICollectionViewFlowLayout()
        let collectionVC = SFDragCollectionViewController(collectionViewLayout: layout)
        collectionVC.view.frame = rightView.bounds
        self.rightView.addSubview(collectionVC.view)
        self.addChildViewController(collectionVC)
    }
}
