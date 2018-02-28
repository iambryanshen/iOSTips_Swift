
//
//  NibCollectionViewCell.swift
//  iOSTips
//
//  Created by Brian on 2018/1/10.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class NibCollectionViewCell: UICollectionViewCell, RegisterCellProtocol {
    
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
