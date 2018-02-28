//
//  SFJSONExampleCell.swift
//  iOSTips
//
//  Created by brian on 2018/2/4.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFJSONExampleCell: UITableViewCell {
    
    var jsonExampleModel: SFJSONExampleModel? {
        didSet {
            guard let jsonExampleModel = jsonExampleModel else {
                return
            }
            textLabel?.text = jsonExampleModel.name
            detailTextLabel?.text = "播放时间：\(String(describing: jsonExampleModel.length))"
            let url = URL(string: "\(jsonExampleModel.image ?? "")", relativeTo: baseURL)
            imageView?.kf.setImage(with: url)
        }
    }
}
