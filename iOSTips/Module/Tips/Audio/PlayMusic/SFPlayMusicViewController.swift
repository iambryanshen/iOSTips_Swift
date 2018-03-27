//
//  SFPlayMusicViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/27.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation

class SFPlayMusicViewController: UIViewController {
    
    @IBAction func playMusic(_ sender: Any) {
        SFMusicTool.playMusic(musicName: "Lullaby.mp3")
    }
    @IBAction func pauseMusic(_ sender: Any) {
        SFMusicTool.pauseMusci()
    }
    @IBAction func endMusic(_ sender: Any) {
        SFMusicTool.stopMusic()
    }
    
    // 快进
    @IBAction func fastForward(_ sender: Any) {
        SFMusicTool.setCurrentTime(currentTime: 60.0)
    }
}
