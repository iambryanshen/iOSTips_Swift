//
//  SFNSLayoutAnchorViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/27.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFNSLayoutAnchorViewController: UIViewController {

    var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        addRedView()
        
        addImageView()
    }
}

extension SFNSLayoutAnchorViewController {
    
    func addRedView() {
        
        redView = UIView()
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        
        setAnchor()
    }
    
    func setConstraint() {
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: redView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: redView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: redView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leadingMargin,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: redView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailingMargin,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
    }
    
    func setAnchor() {
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
////            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            redView.topAnchor.constraint(equalTo: view.topAnchor),
//            redView.widthAnchor.constraint(equalToConstant: 100),
//            redView.heightAnchor.constraint(equalToConstant: 100),
//            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            redView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
    }
}

extension SFNSLayoutAnchorViewController {
    func addImageView() {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "liuxinjia.JPG"))
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
            ])
    }
}
