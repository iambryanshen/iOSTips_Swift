//
//  FlashProtocol.swift
//  iOSTips
//
//  Created by Brian on 2018/1/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

protocol FlashProtocol {}

extension FlashProtocol where Self: UIView {
    func flashAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
        }) { (isFinished) in
            UIView.animate(withDuration: 1, animations: {
                self.alpha = 0
            })
        }
    }
}
