//
//  SFAudioTool.swift
//  iOSTips
//
//  Created by brian on 2018/3/27.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation


class SFAudioTool: NSObject {
    
    
    /// 播放音效
    ///
    /// - Parameters:
    ///   - name: 音频文件的名称
    ///   - isAlert: 是否播放音效时，手动带有震动效果
    ///   - completion: 播放完成后的回调
    class func playAudioWithName(name: String, isAlert: Bool, completion:(() -> Void)? = nil) {
        
        // 定义SystemSoundID
        var soundID: SystemSoundID = 0
        
        // 获取音频文件路径url
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            return
        }
        
        // 根据文件路径url给SystemSoundID赋值
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        
        if isAlert {
            // 播放音效，有震动
            AudioServicesPlayAlertSoundWithCompletion(soundID) {
                // 当播放完成时，根据SystemSoundID释放内存资源
                AudioServicesDisposeSystemSoundID(soundID)
                if let completion = completion {
                    completion()
                }
            }
        } else {
            // 播放音效，没有震动
            AudioServicesPlaySystemSoundWithCompletion(soundID, {
                // 当播放完成时，根据SystemSoundID释放内存资源
                AudioServicesDisposeSystemSoundID(soundID)
                if let completion = completion {
                    completion()
                }
            })
        }
    }
}
