//
//  SFBaseViewController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/17.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

let kTableViewCell = "kTableViewCell"

class SFBaseViewController: UIViewController {
    
    // 分组标题
    var headers: [String]?
    var dataSource: [[String: UIViewController]]?
    
    // 技术点标题
    lazy var keys: [[String]] = [[String]]()
    // 技术点控制器
    lazy var viewControllers: [[UIViewController]] = [[UIViewController]]()
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableViewCell)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataSource = dataSource else {return}
        
        for dict in dataSource {
            keys.append(Array(dict.keys))
            viewControllers.append(Array(dict.values))
        }

        setupSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

extension SFBaseViewController {
    func setupSubviews() {
        view.addSubview(tableView)
    }
}

//MARK: - UITableViewDataSource
extension SFBaseViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCell, for: indexPath)
        cell.textLabel?.text = keys[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers?[section]
    }
}

//MARK: - UITableViewDelegate
extension SFBaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = viewControllers[indexPath.section][indexPath.row]
        vc.title = keys[indexPath.section][indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
