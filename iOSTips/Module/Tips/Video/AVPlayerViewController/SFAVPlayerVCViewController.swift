//
//  SFAVPlayerVCViewController.swift
//  iOSTips
//
//  Created by brian on 2018/4/16.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVKit

class SFAVPlayerVCViewController: UIViewController {

    @IBAction func playVideo() {
        let playerVC = AVPlayerViewController()
        let url = URL(string: "http://cache.utovr.com/65e1e2929d924d6f80f6cfb8b06b38da/L4_ftqcoiyjhysyii89.mp4")!
        let player = AVPlayer(url: url)
        playerVC.player = player
        present(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
}
