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
        
        /**
         To enable adjustable playback rate for an audio player, set this property to true after you initialize the player and before you call the prepareToPlay() instance method for the player.
         */
        player.enableRate = true
        
        player.prepareToPlay()
        
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
        // 系统对属性currentTime做了容错处理，不需要我们判断小于0和小于整首歌时间长度的判断
        player?.currentTime = currentTime
    }
    
    /// 快进几秒
    ///
    /// - Parameter time: 几秒
    class func fastForwardWithSecond(time: TimeInterval) {
        player?.currentTime += time
    }
    
    /// 几倍速播放
    ///
    /// - Parameter rate: 倍速（1等于原速度，0.5等于一半的速度，2等于两倍速）
    class func severalRate(rate: Float) {
        /**
         设置倍速一定要设置player?.enableRate = true，且该属性的设置要在player创建时设置
         */
        player?.rate = rate
    }
    
    /// 调整播放音量
    ///
    /// - Parameter volume: 音量大小
    class func volumeChange(volume: Float) {
        player?.volume = volume
    }
}
