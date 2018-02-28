//
//  SFRefreshControlViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/2.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

let kRefreshControlID = "kRefreshControlID"

class SFRefreshControlViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kRefreshControlID)
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
    }
}

extension SFRefreshControlViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRefreshControlID, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)行"
        return cell
    }
}
