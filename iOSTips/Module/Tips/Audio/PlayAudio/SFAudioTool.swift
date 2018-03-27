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
    ///   - completion: 播放完成后的回调
    class func playAudioWithName(name: String, completion:(() -> Void)? = nil) {
        
        // 定义SystemSoundID
        var soundID: SystemSoundID = 0
        
        // 获取音频文件路径url
        let url = Bundle.main.url(forResource: name, withExtension: nil)
        
        // 根据文件路径url给SystemSoundID赋值
        AudioServicesCreateSystemSoundID(url! as CFURL, &soundID)
        
        // 播放音效，没有震动
        // AudioServicesPlaySystemSound(soundID)
        // 播放音效，有震动
        AudioServicesPlayAlertSoundWithCompletion(soundID) {
            if let completion = completion {
                completion()
            }
        }
    }
}
