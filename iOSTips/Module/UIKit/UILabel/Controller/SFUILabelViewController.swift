//
//  SFUILabelViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/18.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFUILabelViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         以下方法不可同时设置，同时设置，后设置的会覆盖先设置的
         原因：实现方式是通过label的attributeText属性实现，重复设置，重复给attributeText属性赋值会导致后设置的覆盖先设置的
         */
        // 修改文字的行间距和字间距
        testLabel.sf.changeLabelRowSpace(lineSpace: 10, wordSpace: 10)
        
        // 显示指定个数的文字
        testLabel.sf.specifiesTheNumberOfWordsToDisplay(number: 200)
    }
}
