//
//  SFShakeAnimationViewController.swift
//  iOSTips
//
//  Created by Brian on 2018/1/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFShakeAnimationViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: SFTextField!
    @IBOutlet weak var passwordTextField: SFTextField!
    @IBOutlet weak var tipLabel: SFLabel!
    @IBOutlet weak var loginButton: SFButton!
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        usernameTextField.shakeAnimation()
        passwordTextField.shakeAnimation()
        loginButton.shakeAnimation()
        tipLabel.flashAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

class SFTextField: UITextField, ShareAnimationProtocol {}
class SFLabel: UILabel, FlashProtocol {}
class SFButton: UIButton, ShareAnimationProtocol {}
