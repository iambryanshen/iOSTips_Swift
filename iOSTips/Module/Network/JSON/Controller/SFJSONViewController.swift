//
//  SFJSONViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/4.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFJSONViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = [""]
        dataSource = [["JSONSerialization": SFJSONSerializationViewController(),
                      "JSONExample": SFJSONExampleTableViewController()]
        ]
        
        super.viewDidLoad()
    }
}
