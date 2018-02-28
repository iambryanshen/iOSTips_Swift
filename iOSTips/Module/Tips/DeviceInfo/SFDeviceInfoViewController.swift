//
//  SFDeviceInfoViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDeviceInfoViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "deviceInfo")
        if indexPath.row == 0 {
            cell.textLabel?.text = "设备型号"
            cell.detailTextLabel?.text = UIDevice.modelName0
        }
        return cell
    }
}
