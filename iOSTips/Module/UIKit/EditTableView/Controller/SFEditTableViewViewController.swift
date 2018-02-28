//
//  SFEditTableViewViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/19.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFEditTableViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
}

extension SFEditTableViewViewController {
    func setupSubviews() {
        let tableView = SFEditTableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension SFEditTableViewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
