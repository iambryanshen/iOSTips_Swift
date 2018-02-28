//
//  SFDragTableViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/3.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFDragTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\(indexPath.section)组, \(indexPath.row)行"
        
        return cell
    }
}
