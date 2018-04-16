//
//  SFAVPlayerViewController.swift
//  iOSTips
//
//  Created by brian on 2018/4/15.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation

/*
 AVPlayer的优点：
 AVPlayer的缺点：单纯播放视频，没有显示界面，如果希望视频显示出来需要借助AVPlayerLayer层才能显示出来
 
 创建AVPlayer通过以上两种方式都可以
    > public init(url URL: URL)
    > public init(playerItem item: AVPlayerItem?)
 
 切换AVPlayerItem通过AVPlayerLayer的player播放器的replaceCurrentItem实现
 */

class SFAVPlayerViewController: UIViewController {

    lazy var playerLayerByURL: AVPlayerLayer = {
        let url = URL(string: "http://7xnvxr.com1.z0.glb.clouddn.com/5fc5ef97a05d4e8481058a401f054086/L4_nvqjpassesg4dytj.mp4")!
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        return playerLayer
    }()
    
    lazy var playerLayerByPlayerItem: AVPlayerLayer = {
        let url = URL(string: "http://cache.utovr.com/65e1e2929d924d6f80f6cfb8b06b38da/L4_ftqcoiyjhysyii89.mp4")!
        let playerItem = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        return playerLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(playerLayerByURL)
        playerLayerByURL.player?.play()
        
        /*
         or
         
         view.layer.addSublayer(playerLayerByPlayerItem)
         playerLayerByPlayerItem?.play()
         */
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayerByURL.frame = view.bounds
        
        /*
         or
        
         playerLayerByPlayerItem.frame = view.bounds
         */
    }
    
    
    @IBAction func replaceVideo() {
        let url = URL(string: "http://cache.utovr.com/s1tytu9bfy2znke4w8/L3_2880_5_25.mp4")!
        let playerItem = AVPlayerItem(url: url)
        playerLayerByURL.player?.replaceCurrentItem(with: playerItem)
    }
}
