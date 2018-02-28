//
//  TextFieldProtocol.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

protocol TextFieldProtocol {
    func setupInitContent()
}

extension CityTextField: TextFieldProtocol {}
extension DateTextField: TextFieldProtocol {}
extension CountryTextField: TextFieldProtocol {}
