//
//  SFUploadTaskViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFUploadTaskViewController: SFBaseViewController {

    override func viewDidLoad() {
        
        dataSource = [["上传资源": SFUploadSthViewController(),
                       "多值参数": SFMultipleParamViewController(),],]
        super.viewDidLoad()
    }
}
