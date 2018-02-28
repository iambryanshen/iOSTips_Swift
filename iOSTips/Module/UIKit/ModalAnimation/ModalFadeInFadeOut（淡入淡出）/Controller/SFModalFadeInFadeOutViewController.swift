//
//  SFModalFadeInFadeOutViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/15.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFModalFadeInFadeOutViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 50))
        button.center = view.center
        button.setTitle("present", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(jumpToModalPresentedVC), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(button)
    }
    
    @objc func jumpToModalPresentedVC() {
        
        let modalPresentedVC = SFModalPresentedViewController()
//        modalPresentedVC.modalTransitionStyle = .crossDissolve
//        modalPresentedVC.modalTransitionStyle = .coverVertical
//        modalPresentedVC.modalTransitionStyle = .flipHorizontal
//        modalPresentedVC.modalTransitionStyle = .partialCurl
        modalPresentedVC.modalPresentationStyle = .currentContext
//        modalPresentedVC.modalPresentationStyle = .custom
        self.present(modalPresentedVC, animated: true) {
            print("present success")
        }
    }
}

class ModalFadeInFadeOut: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
