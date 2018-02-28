//
//  AppDelegate.swift
//  iOSTips
//
//  Created by Brian on 2017/12/16.
//  Copyright © 2017年 brian. All rights reserved.
//

/*
 #import <UIKit/UIKit.h>
 #import "AppDelegate.h"
 
 // Creates the application object and the application delegate and sets up the event cycle.
 
 // This function instantiates the application object from the principal class and instantiates the delegate (if any) from the given class and sets the delegate for the application. It also sets up the main event loop, including the application’s run loop, and begins processing events. If the application’s Info.plist file specifies a main nib file to be loaded, by including the NSMainNibFile key and a valid nib file name for the value, this function loads that nib file.
 
 int main(int argc, char * argv[]) {
    @autoreleasepool {
 
        /*
        第一个参数：The count of arguments in argv; this usually is the corresponding parameter to main.
        第二个参数：A variable list of arguments; this usually is the corresponding parameter to main.
        第三个参数：The name of the UIApplication class or subclass. If you specify nil, UIApplication is assumed.（ @UIApplication == nil ）
        第四个参数：The name of the class from which the application delegate is instantiated. If principalClassName designates a subclass of UIApplication, you may designate the subclass as the delegate; the subclass instance receives the application-delegate messages. Specify nil if you load the delegate object from your application’s main nib file.
        */
 
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
 }
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*
         方案一：自己创建根控制器
         self.window = UIWindow.init(frame: UIScreen.main.bounds)
         let rootVC = UIViewController()
         self.window?.rootViewController = rootVC
         self.window?.makeKeyAndVisible()
         */
        
        /*
         方案二：通过storyboard加载箭头指向的控制器
         self.window = UIWindow.init(frame: UIScreen.main.bounds)
         let sb = UIStoryboard.init(name: "CustomVC", bundle: nil)
         let rootVC = sb.instantiateInitialViewController()
         self.window?.rootViewController = rootVC
         self.window?.makeKeyAndVisible()
         */
        
        /*
         方案三：通过storyboard加载指定storyID的控制器
         self.window = UIWindow.init(frame: UIScreen.main.bounds)
         let sb = UIStoryboard.init(name: "CustomVC", bundle: nil)
         let rootVC = sb.instantiateViewController(withIdentifier: "CustomVC")
         self.window?.rootViewController = rootVC
         self.window?.makeKeyAndVisible()
         */
        
        // 本项目使用方案一
        self.window = UIWindow()    // 从XCode7以后不再需要制定window的frame，系统会默认为屏幕大小
        self.window?.rootViewController = SFTabBarController()
        self.window?.makeKeyAndVisible() // 等同于 self.window?.hidden = true;
        /*
         makeKeyAndVisible做了哪些事情？
         1. 设置当前窗口为应用程序的根控制器
         [UIApplication sharedApplication].keyWindow = self.window;
         2. 显示Window
         self.window.hidden = YES;
         (Tips: 设置self.window.hidden = YES;也能实现和makeKayAndVisible同样的效果表明，self.window.hidden = YES;会通知UIWindow添加rootVC的view并显示出来
         2. 把窗口的根控制器添加到窗口上面
         [self.window addSubview:self.window.rootViewController.view];
         */
        
        /*
         UIWindow可以设置级别的（可以用来隐藏状态栏）
         UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
         */
        self.window?.windowLevel = UIWindowLevelNormal;
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

