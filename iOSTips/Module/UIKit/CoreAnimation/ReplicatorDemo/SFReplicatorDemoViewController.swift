//
//  SFReplicatorDemoViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/20.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFReplicatorDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let replicatorView = Bundle.main.loadNibNamed("SFReplicatorView", owner: nil, options: nil)?.first as! SFReplicatorView
        replicatorView.frame = view.bounds
        view.addSubview(replicatorView)
    }
}
