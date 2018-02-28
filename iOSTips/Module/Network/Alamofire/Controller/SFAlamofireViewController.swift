//
//  SFAlamofireViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFAlamofireViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        dataSource = [["get & post": SFAFGetPostViewController(),
                       "Download": SFDownloadViewController(),
                       "Upload": SFUploadViewController(),
                       "Response解析": SFResponseViewController(),],
        ]
        
        super.viewDidLoad()
    }
}
