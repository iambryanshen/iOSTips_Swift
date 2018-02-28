
//
//  SFUIKitNavigationController.swift
//  iOSTips
//
//  Created by Brian on 2017/12/16.
//  Copyright © 2017年 brian. All rights reserved.
//

/*
 思路：
 1. 我们观察到导航控制器的边缘有滑动返回的手势，所以我们知道导航控制器的边缘一定添加了一个滑动返回的手势
 2. 我们知道创建一个手势需要target、action。
 (UIPanGestureRecognizer(target: <#T##Any?#>, action: <#T##Selector?#>))
 通过打印:
 print(self.navigationController?.interactivePopGestureRecognizer)
 print(self.navigationController?.interactivePopGestureRecognizer?.delegate)
 /*
 Optional(<UIScreenEdgePanGestureRecognizer: 0x10de1d050; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x10de0cfe0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x10de1c440>)>>)
 Optional(<_UINavigationInteractiveTransition: 0x10de1c440>)
 */
 3. 根据打印结果我们可以知道边缘滑动手势就是：UIScreenEdgePanGestureRecognizer，该手势的target：UINavigationInteractiveTransition，action：handleNavigationTransition:。
 其中：target为执行action的对象，action实现了滑动返回的功能
 4. 由此我们知道，如果我们创建一个新的手势pan，添加该手势到全屏view，该手势的target设为：UINavigationInteractiveTransition，action：handleNavigationTransition:我们就可以实现全屏滑动返回的功能
 */

import UIKit

class SFUIKitNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 获取系统导航控制器自带的target对象
        let target = self.interactivePopGestureRecognizer?.delegate

        // 2. 创建全屏滑动返回手势，调用系统导航控制器自带的target对象的action方法
        let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))

        // 3. 给导航控制器的view添加手势
        self.view.addGestureRecognizer(pan)

        // 4. 禁止使用系统导航控制器自带的边缘滑动返回手势
        self.interactivePopGestureRecognizer?.isEnabled = false

        // 5. 设置手势的代理，在特定情况下（非根控制器）手势执行
        pan.delegate = self
    }
}

extension SFUIKitNavigationController: UIGestureRecognizerDelegate {
    // 当导航控制器只有一个子控制器的时候，那个控制器肯定就是根控制器，当处于根控制器时，不需要滑动返回功能，在这里禁止滑动返回手势
    // 如果当前控制器不是导航控制器，那么如果给该界面添加全屏滑动返回手势，那么该界面及该界面的子控制器界面就一定需要全屏滑动返回手势，则不需要拦截手势，做以下这样的判断
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }
}
