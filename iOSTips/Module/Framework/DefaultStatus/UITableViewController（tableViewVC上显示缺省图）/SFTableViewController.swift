//
//  SFTableViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/26.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFTableViewController: UITableViewController, DefaultStatusProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        setupDefaultStatusView()
    }
    
    func setupDefaultStatusView() {
        
        let status = Status(title: "title", description: "description", image: UIImage(named: "image.png")) {
            self.hide()
        }
        
        show(status: status)
    }
}

// MARK: - Table view data source
extension SFTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section)行,\(indexPath.row)列"
        return cell
    }
}
