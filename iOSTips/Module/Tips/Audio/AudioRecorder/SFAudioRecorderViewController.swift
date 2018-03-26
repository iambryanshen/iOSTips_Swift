//
//  SFAudioRecorderViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation

class SFAudioRecorderViewController: UIViewController {
    
    var recorder: AVAudioRecorder?

    @IBAction func startRecording(_ sender: UIButton) {
        
        /// 创建录制音频的存储路径
        let url = URL(string: "\(cachePath)/123.wav")!

        /**
         录音设置
         - AVSampleRateKey：音频采样率（采集声音的频率)
         - AVNumberOfChannelsKey：声道数
        */
        let settings = [AVSampleRateKey: 44100, AVNumberOfChannelsKey: 0]
        
        /// 创建录音对象
        guard let recorder = try? AVAudioRecorder(url: url, settings: settings) else {
            print("创建录音对象时异常！")
            return
        }
        self.recorder = recorder
        
        /// 开始/恢复录音
        recorder.record()
    }
    
    @IBAction func endRecording(_ sender: Any) {
        
        /// 停止并结束录音
        recorder?.stop()
    }
}
