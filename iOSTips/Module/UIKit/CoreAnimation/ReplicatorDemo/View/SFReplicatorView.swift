//
//  SFReplicatorView.swift
//  iOSTips
//
//  Created by brian on 2018/3/20.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFReplicatorView: UIView {
    
    @IBOutlet weak var replicatorIV: UIImageView!
    
    /*
     在Swift中layerClass为只读不可写属性
     在Objc中layerClass为可读可写属性，可以通过重写layerClass修改控制器view的layer类型
     
     实现倒影的思路：
        1. 修改Controller的view的layer为CAReplicatorLayer
        2. 通过对Controller的view的layer进行操作
            > 复制两层：instanceCount
            > 设置颜色渐变：instanceRedOffset，instanceGreenOffset，instanceBlueOffset
            > 绕x轴旋转180度：instanceTransform
     由于在Swift中layerClass为只读不可写属性，无法通过重写View的layer对View的layer的类型进行修改（修改为CAReplicatorLayer），故以上思路不可行
     
     在OC的工程中通过以上思路实现倒影效果
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
