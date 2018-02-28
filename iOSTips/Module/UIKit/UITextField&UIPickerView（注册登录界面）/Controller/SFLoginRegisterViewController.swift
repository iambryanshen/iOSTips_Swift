//
//  SFLoginRegisterViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/22.
//  Copyright © 2017年 brian. All rights reserved.
//

/*
 重点一：
 > 点击UITextField会弹出inputView，默认是系统键盘
 > 如果想更改成自定义显示的内容，比如：日历等。
 > 自定义类继承UITextField，在初始化方法，比如：awakeFromNib中，修改inputView为自定义view
 重点二：
 > View只给控件设置内容
 > Model负责处理数据
 > Controller负责处理逻辑
 重点三：
 > KVC给类属性赋值，实际上是找到key对应的属性的set方法，调用set方法给属性赋值
 > 如果没有找到属性对应的set方法，会去找到key对应的属性，如果找到，直接给属性赋值
 > 如果没有找到key对应的属性，调用setValue(forUndefinedKey)方法直接报错
 * 如果类中没有定义数据源返回的全部属性，又不希望因为KVC找不到对应属性报错，可以重写setValue(forUndefinedKey)方法，让其什么也不做，从而也就不会报错
 */

import UIKit

class SFLoginRegisterViewController: UIViewController {

    @IBOutlet weak var countryTextField: CountryTextField!
    @IBOutlet weak var dateTextField: DateTextField!
    @IBOutlet weak var cityTextField: CityTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryTextField.delegate = self
        dateTextField.delegate = self
        cityTextField.delegate = self
    }
}

extension SFLoginRegisterViewController: UITextFieldDelegate {
    
    /// 第一次点击textField，弹出inputView时调用
    ///
    /// - Parameter textField: 因为都遵守了UITextFieldDelegate，点击那个textField，传递过来的就是哪个UITextField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TextFieldProtocol {
            textField.setupInitContent()
        }
    }
}
