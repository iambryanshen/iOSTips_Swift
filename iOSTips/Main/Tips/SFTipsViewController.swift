//
//  SFTipsViewController.swift
//  iOSTips
//
//  Created by brian on 2018/1/8.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFTipsViewController: SFBaseViewController {

    override func viewDidLoad() {

        headers = ["面向协议开发", "Runtime", "UIApplication", "访问系统", "父子控制器", "音频", "视频"]
        dataSource = [["使用协议从xib中加载UIView": SFProtocolViewController(),
                       "使用协议封装登录按钮抖动动画": SFShakeAnimationViewController(),
                       "使用协议注册UITableViewCell": SFRegisterCellViewController(),],
                      
                      ["Runtime": SFRuntimeViewController(),],
                      
                      ["跳转到系统应用": SFAppJumpViewController(),
                       "UIApplication设置": SFSystemSettingViewController(),],
                      
                      ["访问系统相册": SFSystemPhotoViewController(),
                       "获取设备信息": SFDeviceInfoViewController(),],
                      
                      ["类似UITabBarController的父子控制器": SFFatherChildVCViewController(),],
                      
                      ["1. 录音": SFAudioRecorderViewController(),
                       "2. 播放音效": SFPlayAudioViewController(),
                       "3. 播放音乐": SFPlayMusicViewController(),
                       "4. 播放远程音乐": SFPlayRemoteMusicViewController(),],
                      
                      ["AVPlayer": SFAVPlayerViewController(),
                       "AVPlayerVC": SFAVPlayerVCViewController(),],
        
        ]
        
        super.viewDidLoad()
    }
}
