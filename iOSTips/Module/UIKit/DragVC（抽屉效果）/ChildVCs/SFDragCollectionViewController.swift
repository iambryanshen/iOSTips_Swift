//
//  SFDragCollectionViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/3.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SFDragCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = UIColor.randomColor()
    
        return cell
    }
}
