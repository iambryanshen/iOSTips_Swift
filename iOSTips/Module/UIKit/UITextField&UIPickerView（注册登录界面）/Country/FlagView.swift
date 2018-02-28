//
//  FlagView.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class FlagView: UIView {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    
    var countryModel: CountryModel? {
        didSet {
            guard let countryModel = countryModel else {
                return
            }
            countryName.text = countryModel.name
            countryFlag.image = countryModel.flagImage
        }
    }
}
