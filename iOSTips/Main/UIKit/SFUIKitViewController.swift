//
//  SFUIKitViewController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/16.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class SFUIKitViewController: SFBaseViewController {
    
    override func viewDidLoad() {
       
        headers = ["控件", "动效", "转场动效", "AutoLayout", "iPhone X", "Alert", "手势识别", "UIView动画", "控制器的切换方式"]
        
        dataSource = [["UILabel扩展设置文字样式": SFUILabelViewController(),
                 "UITextField&UIPickView实现注册登录界面": SFLoginRegisterViewController(),
                 "UITableViewCell编辑删除": SFEditTableViewViewController(),
                 "UICollectionView的生命周期": SFUICollectionViewLifeCycleViewController(),],
                      
                ["流水布局": SFWaterFallViewController(),
                 "仿QQ主页效果(抽屉效果)": SFDragDemoViewController(),],
                
                ["PushPop动效": SFPushPopAnimationViewController(), "Modal动效": SFModalAniamtionViewController(),],
                
                ["NSLayoutAnchor": SFNSLayoutAnchorViewController(),
                 "LayoutGuide": SFLayoutGuideViewController(),
                 "UIStackView": SFUIStackViewViewController()],
                
                ["Safe Area": SFSafeAreaViewController(),],
                
                ["系统弹框": SFAlertViewController(),],
                
                ["点按、长按、旋转、放大、清扫": SFGestureViewController(),],
                
                ["transform": SFTransformViewController(),],
                
                ["Modal": SFModalViewController(),],
        ]
        
        super.viewDidLoad()
    }
}
