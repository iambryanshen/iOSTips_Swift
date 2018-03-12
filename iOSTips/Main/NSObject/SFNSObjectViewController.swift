//
//  SFNSObjectViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFNSObjectViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = ["iOS本地存储", "定时器"]
        
        dataSource = [["Plist": SFPlistViewController(),
                       "UserDefaults": SFUserDefaultsViewController(),
                       "NSKeyedArchiver": SFNSKeyedArchiverViewController(),
                       "NSCache": SFNSCacheViewController(),
                       ],
                      
                      ["CADisplayLink": SFDisplayLinkViewController(),],
        ]
        
        super.viewDidLoad()
    }
}
