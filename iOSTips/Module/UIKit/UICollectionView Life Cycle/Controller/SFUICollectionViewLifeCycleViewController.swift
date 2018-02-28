//
//  SFUICollectionViewLifeCycleViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/3.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFUICollectionViewLifeCycleViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = view.bounds.size
        layout.minimumLineSpacing = 0
        let collectionView: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "SFLifeCycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SFLifeCycleCollectionViewCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)
    }
}

extension SFUICollectionViewLifeCycleViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SFLifeCycleCollectionViewCell {
            print(type(of: self), #function, cell.titleLabel.text ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SFLifeCycleCollectionViewCell {
            print(type(of: self), #function, cell.titleLabel.text ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        print(type(of: self), #function)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print(type(of: self), #function)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(type(of: self), #function)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print(type(of: self), #function)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(type(of: self), #function)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(type(of: self), #function)
        print("-----------------------------------------------------------------------------")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print(type(of: self), #function)
    }
}

extension SFUICollectionViewLifeCycleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SFLifeCycleCollectionViewCell", for: indexPath) as! SFLifeCycleCollectionViewCell
        cell.backgroundColor = UIColor.randomColor()
        cell.titleLabel.text = "\(indexPath.section)组, \(indexPath.item)个"
        return cell
    }
}

extension SFUICollectionViewLifeCycleViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 0, height: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 50
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
}
