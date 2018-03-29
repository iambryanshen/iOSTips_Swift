//
//  SFPlayMusicViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/27.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation
/*
 实现后台播放音频只需要四步：
    1. 勾选后台播放模式：在capabilities中勾选background modes中的audio、AirPlay、picture in picture
    2. 在iOS中每个应用都有一个音频会话，这个会话就通过AVAudioSession表示，AVAudioSession同样存在于AVFoundation框架中，它是代理设计的模式，通过sharedInstance()访问
        let session = AVAudioSession.shareInstance()
    3. 设置音频会话类别
        session.setCategory(AVAudioSessionCategoryPlayback)
    4. 激活音频会话
        session.setActive(true)
 */

class SFPlayMusicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 获取音频会话
        let session = AVAudioSession.sharedInstance()

        do {
            // 2. 设置会话类别
            try session.setCategory(AVAudioSessionCategoryPlayback)
            
            // 3. 激活音频会话
            try session.setActive(true)
        } catch let errorMsg {
            print(errorMsg)
        }
    }
    
    @IBAction func playMusic(_ sender: Any) {
        SFMusicTool.playMusic(musicName: "Lullaby.mp3")
    }
    
    @IBAction func pauseMusic(_ sender: Any) {
        SFMusicTool.pauseMusci()
    }
    
    @IBAction func endMusic(_ sender: Any) {
        SFMusicTool.stopMusic()
    }
    
    // 快进到指定时间
    @IBAction func fastForwardSpecificTime(_ sender: Any) {
        SFMusicTool.setCurrentTime(currentTime: 60.0)
    }
    
    // 快进指定秒数
    @IBAction func fastForwardSpecificSecond(_ sender: UIButton) {
        SFMusicTool.fastForwardWithSecond(time: 5)
    }
    
    // 倍速播放
    @IBAction func severalRate(_ sender: UIButton) {
        SFMusicTool.severalRate(rate: 3)
    }
    
    // 调整播放音量大小
    @IBAction func volumeChange(_ sender: UISlider) {
        SFMusicTool.volumeChange(volume: sender.value)
    }
}
