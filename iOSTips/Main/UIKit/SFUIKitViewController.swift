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
       
        headers = ["控件", "动效", "转场动效", "AutoLayout", "iPhone X", "Alert", "手势识别", "UIView Transform", "控制器的切换方式", "Quartz2D", "核心动画（CoreAnimation）"]
        
        dataSource = [["1：UILabel扩展设置文字样式": SFUILabelViewController(),
                 "2：UITextField&UIPickView实现注册登录界面": SFLoginRegisterViewController(),
                 "3：UITableViewCell编辑删除": SFEditTableViewViewController(),
                 "4：UICollectionView的生命周期": SFUICollectionViewLifeCycleViewController(),],
                      
                ["1：流水布局": SFWaterFallViewController(),
                 "2：仿QQ主页效果(抽屉效果)": SFDragDemoViewController(),],
                
                ["1：PushPop动效": SFPushPopAnimationViewController(),
                 "2：Modal动效": SFModalAniamtionViewController(),],
                
                ["1：NSLayoutAnchor": SFNSLayoutAnchorViewController(),
                 "2：LayoutGuide": SFLayoutGuideViewController(),
                 "3：UIStackView": SFUIStackViewViewController()],
                
                ["1：Safe Area": SFSafeAreaViewController(),],
                
                ["1：系统弹框": SFAlertViewController(),],
                
                ["1：点按、长按、旋转、放大、清扫": SFGestureViewController(),],
                
                ["1：transform": SFTransformViewController(),
                 "2：UIView的拖拽": SFDragUIViewViewController(),],
                
                ["1：Modal": SFModalViewController(),],
                
                ["1：基础图形": SFBaseGraphicsViewController(),
                 "2：自定义进度圆圈": SFDrawProgressViewController(),
                 "3：饼图": SFPieChartViewController(),
                 "4：画文字": SFDrawTextViewController(),
                 "5：上下文状态栈（画不同颜色“十”字）": SFContextStatusStackViewController(),
                 "6：上下文的矩阵操作": SFContextMatrixOperationsViewController(),
                 "7：图片加水印": SFImageWaterMarkViewController(),
                 "8：使用Quartz 2D给图片加圆角": SFRoundImageViewController(),
                 "9：屏幕截屏": SFScreenShotViewController(),],
                
                ["1：CALayer":  SFCALayerViewController(),
                 "2：CATransform3D": SFCATransform3DViewController(),
                 "3：隐式动画": SFImplicitAnimationViewController(),
                 "4：CALayer实现时钟": SFCALayerClockViewController(),
                 "5：CABasicAnimation": SFCABasicAnimationViewController(),
                 "6：CAKeyFrameAnimation": SFCAKeyAnimationViewController(),
                 "7：CATransition": SFCATransitionViewController(),
                 "8：CAAnimationGroup": SFCAAnimationGroupViewController(),
                 "9：UIView动画和CoreAnimation的不同": SFViewAnimAndCoreAnimDifferentViewController(),
                 "10": UIViewController(),
                 "11：图片折叠": SFImageFoldViewController(),
                 "12：音乐震动条": SFMusicShakeViewController(),
                 "13：ReplicatorDemo：倒影": SFReplicatorDemoViewController(),
                 "14：ReplicatorDemo：粒子效果": SFParticleEffectsViewController(),],
        ]
        
        super.viewDidLoad()
    }
}
