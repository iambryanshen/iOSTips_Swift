//
//  SFDataTaskViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/6.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDataTaskViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        headers = ["Get & Post", "文件下载"]
        dataSource = [["Get & Post": SFGetPostViewController(),],
                      ["FileHandle": SFFileHandleViewController(),
                       "OutputStream": SFOutputStreamViewController(),],
        ]
        
        super.viewDidLoad()
    }
}
