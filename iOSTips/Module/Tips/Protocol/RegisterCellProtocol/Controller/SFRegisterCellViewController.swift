//
//  SFRegisterCellViewController.swift
//  iOSTips
//
//  Created by Brian on 2018/1/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFRegisterCellViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        var frame = self.view.bounds
        frame.size.height = frame.size.height * 0.5
        let tableView: UITableView = UITableView(frame: frame, style: .grouped)
        tableView.dataSource = self
        tableView.registerCell(cell: CodeTableViewCell.self)
        tableView.registerCell(cell: NibTableViewCell.self)
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        var frame = self.view.frame
        frame.size.height = frame.size.height * 0.5
        frame.origin.y = frame.size.height
        let collectionView: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.registerCell(cell: CodeCollectionViewCell.self)
        collectionView.registerCell(cell: NibCollectionViewCell.self)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        view.addSubview(collectionView)
    }
}

//MARK: - UITableViewDataSource
extension SFRegisterCellViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let nibCell = tableView.dequeueReusableCell(indexPath: indexPath) as NibTableViewCell
            nibCell.titleLabel?.text = "\(indexPath.section)组, \(indexPath.row)行"
            return nibCell
        } else {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CodeTableViewCell
            cell.textLabel?.text = "\(indexPath.section)组, \(indexPath.row)行"
            return cell
        }
    }
}

//MARK: - UICollectionViewDataSource
extension SFRegisterCellViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as CodeCollectionViewCell
            cell.backgroundColor = UIColor.green
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as CodeCollectionViewCell
            cell.backgroundColor = UIColor.randomColor()
            return cell
        }
    }
}
