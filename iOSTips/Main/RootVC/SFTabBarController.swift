//
//  SFTabBarController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/16.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAllChildVCs()
    }
}

extension SFTabBarController {
    
    func setupAllChildVCs() {
        
        let uikitVC = SFUIKitViewController()
        uikitVC.title = "UIKit"
        let uikitNavigationVC = SFUIKitNavigationController(rootViewController: uikitVC)
        addChildViewController(uikitNavigationVC)
        
        let nsobjectVC = SFNSObjectViewController()
        nsobjectVC.title = "NSObject"
        let nsobjectNavigationVC = SFNSObjectNavigationController(rootViewController: nsobjectVC)
        addChildViewController(nsobjectNavigationVC)
        
        let frameworkVC = SFFrameworkViewController()
        frameworkVC.title = "Framework"
        let frameworkNavigationVC = SFFrameworkNavigationController(rootViewController: frameworkVC)
        addChildViewController(frameworkNavigationVC)
        
        let networkVC = SFNetworkViewController()
        networkVC.title = "Network"
        let networkNavigationVC = SFNetworkNavigationController(rootViewController: networkVC)
        addChildViewController(networkNavigationVC)
        
        let tipsVC = SFTipsViewController()
        tipsVC.title = "Tips"
        let tipsNavigationVC = SFTipsNavigationController(rootViewController: tipsVC)
        addChildViewController(tipsNavigationVC)
    }
}
