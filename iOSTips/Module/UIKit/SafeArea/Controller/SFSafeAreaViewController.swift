//
//  SFSafeAreaViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/28.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFSafeAreaViewController: UIViewController {
    
    var whiteView: UIView!
    var redView: UIView!
    
    lazy var customNavigationBar: UINavigationBar = {
        let customNavigationBar: UINavigationBar = UINavigationBar()
        return customNavigationBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupSubviews()
        
        setNavigationBarWithSafeArea()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            print("self.view.safeAreaInsets = ", self.view.safeAreaInsets)
            print("self.view.safeAreaLayoutGuide = ", self.view.safeAreaLayoutGuide.bottomAnchor)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension SFSafeAreaViewController {
    
    func setupSubviews() {
        
        whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        view.addSubview(whiteView)
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.init(item: whiteView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: whiteView, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: whiteView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: whiteView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            
            // additionalSafeAreaInsets代表控制器view四周的额外内边距（相对于可见区域的内边距）
//            self.additionalSafeAreaInsets = UIEdgeInsets(top: 44, left: 44, bottom: 44, right: 44)
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.init(item: whiteView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: whiteView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: whiteView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: whiteView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        }
        
        if #available(iOS 11.0, *) {
            print("whiteView.safeAreaInsets = ", whiteView.safeAreaInsets)
            print("whiteView.safeAreaLayoutGuide.layoutFrame = ", whiteView.safeAreaLayoutGuide.layoutFrame)
        }
        
        redView = UIView()
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.init(item: redView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: redView, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: redView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: redView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.init(item: redView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: redView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: redView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: redView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        }
        
        if #available(iOS 11.0, *) {
            print("redView.safeAreaInsets = ", redView.safeAreaInsets)
        }
        
        let label = UILabel()
        label.text = "redView"
        redView.addSubview(label)
        label.sizeToFit()
    }
    
    func setNavigationBarWithSafeArea() {
        
//        self.navigationController?.isNavigationBarHidden = true
        
        view.addSubview(customNavigationBar)
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44).isActive = true
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIApplication.shared.statusBarFrame.height + 44).isActive = true
            NSLayoutConstraint.init(item: customNavigationBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        }
        
        let label = UILabel()
        label.text = "导航栏"
        customNavigationBar.addSubview(label)
        label.sizeToFit()
    }
}
