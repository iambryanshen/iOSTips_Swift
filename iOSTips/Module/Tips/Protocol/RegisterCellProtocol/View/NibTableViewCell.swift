//
//  NibTableViewCell.swift
//  iOSTips
//
//  Created by Brian on 2018/1/10.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class NibTableViewCell: UITableViewCell, RegisterCellProtocol {
    
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }

    @IBOutlet weak var titleLabel: UILabel!    
}
