//
//  SFMusicTool.swift
//  iOSTips
//
//  Created by brian on 2018/3/27.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation

class SFMusicTool: NSObject {
    
    static var player: AVAudioPlayer?
    
}

extension SFMusicTool {
    
    /// 开始播放
    ///
    /// - Parameter musicName: 资源名称
    class func playMusic(musicName: String) {
        
        // 资源路径URL
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            return
        }
        
        // 如果即将播放的资源和当前正在播放的资源相同，就继续播放
        if let currentUrl = player?.url {
            if currentUrl == url {
                player?.play()
                return
            }
        }
        
        guard let player = try? AVAudioPlayer(contentsOf: url) else {
            return
        }
        self.player = player
        
        player.play()
    }
    
    /// 暂停播放
    class func pauseMusci() {
        player?.pause()
    }
    
    /// 停止播放，同时设置进度到0
    class func stopMusic() {
        player?.currentTime = 0
        player?.stop()
    }
    
    /// 快进到指定时间
    ///
    /// - Parameter currentTime: 指定时间
    class func setCurrentTime(currentTime: TimeInterval) {
        player?.currentTime = currentTime
    }
}
