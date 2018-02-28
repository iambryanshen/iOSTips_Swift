//
//  ImageTableViewCell.swift
//  iOSTips
//
//  Created by Brian on 2017/12/17.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
