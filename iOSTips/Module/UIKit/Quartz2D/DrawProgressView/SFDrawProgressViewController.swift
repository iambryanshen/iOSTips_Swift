//
//  SFDrawProgressViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDrawProgressViewController: UIViewController {

    @IBOutlet weak var progressView: SFDrawProgressView!
    @IBOutlet weak var progressLabel: UILabel!

    @IBAction func valueChange(_ sender: UISlider) {
        let value = String(format: "%.2f%%", sender.value * 100)
        progressLabel.text = value
        progressView.progress = sender.value
    }
}
