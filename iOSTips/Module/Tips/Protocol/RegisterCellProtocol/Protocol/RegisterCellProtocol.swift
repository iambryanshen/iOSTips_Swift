
//
//  RegisterCellProtocol.swift
//  iOSTips
//
//  Created by Brian on 2018/1/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

protocol RegisterCellProtocol {
    static var nib: UINib? { get }
}

extension RegisterCellProtocol {
    static var identifier: String {
        return "\(self)"
    }
    
    static var nib: UINib? {
        return nil
    }
}

extension UITableView {
    
    func registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellProtocol {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        } else {
            register(cell.self, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellProtocol {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellProtocol {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        } else {
            register(cell.self, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellProtocol {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
