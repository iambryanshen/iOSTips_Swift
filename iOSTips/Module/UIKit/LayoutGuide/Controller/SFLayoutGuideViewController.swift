//
//  SFLayoutGuideViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/24.
//  Copyright © 2018年 brian. All rights reserved.
//
/*
 > UILayoutGuide和普通UIKit唯一的区别就是不显示在View的层级中，可以仅仅用作一个占位view辅助布局
 > view的view.layoutMarginsGuide && view.safeAreaLayoutGuide属性表示当前view的除去各种bar的区域（UINavigationBar、UITabBar、SafeArea）
 */

import UIKit

class SFLayoutGuideViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        test()
    }
}

extension SFLayoutGuideViewController {
    func setSubviews() {
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        
        let label = UILabel()
        label.text = "label"
        view.addSubview(label)
        
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        layoutGuide.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        layoutGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor).isActive = true
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor).isActive = true
        redView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor).isActive = true
        
        redView.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 20).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func test() {
        let space1 = UILayoutGuide()
        view.addLayoutGuide(space1)
        
        space1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        space1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        space1.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let saveButton = UIButton(type: .custom)
        view.addSubview(saveButton)
        saveButton.backgroundColor = UIColor.red
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: space1.leadingAnchor).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: space1.centerYAnchor).isActive = true
        
        
        let cancelButton = UIButton(type: .custom)
        view.addSubview(cancelButton)
        cancelButton.backgroundColor = UIColor.green
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: space1.trailingAnchor).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: space1.centerYAnchor).isActive = true
        
        let space2 = UILayoutGuide()
        view.addLayoutGuide(space2)
        
        space2.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor).isActive = true
        space2.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        space2.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let clearButton = UIButton(type: .custom)
        view.addSubview(clearButton)
        clearButton.backgroundColor = UIColor.blue
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: space2.trailingAnchor).isActive = true
        clearButton.centerYAnchor.constraint(equalTo: space2.centerYAnchor).isActive = true

    }
}
