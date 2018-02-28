//
//  SFWaterFallViewController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/16.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit
let kWaterFallCell = "kWaterFallCell"
class SFWaterFallViewController: UIViewController {
    
    var itemCount = 50
    lazy var collectionView: UICollectionView = {
        let layout = SFWaterFallLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // 需要设置当前类为SFWaterFallLayout的数据源，从而给SFWaterFallLayout提供数据源（cell的高度）
        layout.dataSource = self
        // 通过自定义布局实例设置流水布局的列数
        layout.column = 5
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kWaterFallCell)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
}

//MARK: - 子控件
extension SFWaterFallViewController {
    func setupSubviews() {
        view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDelegate
extension SFWaterFallViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            itemCount += 50
            collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension SFWaterFallViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterFallCell, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

//MARK: - 遵守布局的数据源协议SFWaterFallLayoutDataSource，计算每一个cell的高度给布局SFWaterFallLayout
/*
 cell的宽度根据屏幕的宽度 / 列数得到，所以不需要外界告诉SFWaterFallLayout
 cell的高度由内容（一般是图片或者视频的高度）决定，所以需要由外界告诉SFWaterFallLayout
 */
extension SFWaterFallViewController: SFWaterFallLayoutDataSource {
    func sfWaterFallLayoutDataSource(layout: SFWaterFallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(100) + 100)
    }
}
