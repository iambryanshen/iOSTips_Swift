//
//  SFWaterFallLayout.swift
//  iOSTips
//
//  Created by Brian on 2017/12/17.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

protocol SFWaterFallLayoutDataSource: class {
    func sfWaterFallLayoutDataSource(layout: SFWaterFallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat
}

class SFWaterFallLayout: UICollectionViewFlowLayout {
    
    // 遵守该数据源协议的类给SFWaterFallLayout提供每个cell的高度
    weak var dataSource: SFWaterFallLayoutDataSource?
    // 获取内容的最大高度
    lazy var maxHeight: CGFloat = self.sectionInset.top + self.sectionInset.bottom
    // 默认是两行，可以在创建layout的通过，通过layout实例修改column
    var column: Int = 2
    // 包存每个cell关联的attribute
    lazy var attributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    // 保存一行中所有cell的高度，数组初始值为sectionInset.Top，一组cell的外边距
    lazy var cellHeights: [CGFloat] = Array(repeating: self.sectionInset.top, count: column)
}

extension SFWaterFallLayout {
    
    // 该方法默认实现不做任何事情，我们可以通过重写该方法去计算自定义布局的每个cell的attribute（主要是attribute的frame）
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {return}
        
        // 获取第一组cell的个数, 为了给每一个cell绑定关联的attribute
        let cellsCount = collectionView.numberOfItems(inSection: 0)
        
        let itemW: CGFloat = (collectionView.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(column) - 1) * minimumInteritemSpacing) / CGFloat(column)
        
        for index in attributes.count..<cellsCount {
            
            // 创建每一个cell的indexPath，绑定到每一个cell的attribute上
            let indexPath = IndexPath(item: index, section: 0)
            
            // 针对每一个cell创建一个attribute
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 根据一行两列的两个cell获取最小的cell的高度，根据该根据求出cellY, cellH的值
            let minHeight = cellHeights.min()!
            let minHeightIndex = cellHeights.index(of: minHeight)!
            
            let itemX: CGFloat = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            let itemY: CGFloat = minHeight
            guard let height = dataSource?.sfWaterFallLayoutDataSource(layout: self, heightForItemAt: indexPath) else {
                fatalError("未遵守SFWaterFallLayoutDataSource协议，实现协议方法！")
            }
            let itemH: CGFloat = height
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            // 添加设置好cell的frame的attribute到保存的attributes数组中，在需要时给到collectionView
            attributes.append(attribute)
            
            // 每设置一个，都要更新一行cell的高度数组中设置完cell后最小height的height
            cellHeights[minHeightIndex] = cellHeights[minHeightIndex] + height + minimumLineSpacing
        }
        
        // 获取内容的最大高度
        maxHeight = cellHeights.max() ?? 0
    }
}

//MARK: - 返回准备好的布局给系统
extension SFWaterFallLayout {
    /*
     我的理解：重写该方法，提供保存了自己计算的每个cell关联的attribute组成的数组attributes，每个cell显示前，cell布局时都会调用该方法获取cell需要的frame
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

//MARK: - 设置可滚动区域
extension SFWaterFallLayout {
    // 计算出全部内容的宽度、高度。（滚动范围）
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight + sectionInset.bottom)
    }
}
