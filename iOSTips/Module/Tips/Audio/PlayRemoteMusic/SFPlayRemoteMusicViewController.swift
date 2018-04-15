//
//  SFPlayRemoteMusicViewController.swift
//  iOSTips
//
//  Created by brian on 2018/4/15.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation

class SFPlayRemoteMusicViewController: UIViewController {

    
    @IBAction func playRemoteMusic(_ sender: UIButton) {
        
        // 方案一
//        let url = URL(string: "")!
//        let player = AVPlayer(url: url)
//        player.play()
        
        // 方案二
        let url = URL(string: "")!
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        player.play()
    }
}
