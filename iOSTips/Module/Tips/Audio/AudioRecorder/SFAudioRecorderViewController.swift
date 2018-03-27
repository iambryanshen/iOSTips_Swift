//
//  SFAudioRecorderViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/26.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import AVFoundation

/*
 录音的步骤
    1. 创建存储录音的路径URL
    2. 创建录音的一些设置信息
    3. 创建录音对象
    4. 开始录音
 测量录音的音量大小
    1. 打开音量测量的属性：isMeteringEnabled。（测量音量会消耗计算资源，所以默认是关闭的，需要手动开启）
    2. 每隔0.1秒更新当前获取到的音量大小。updateMeters
    3. 获取录音频道的平均音量大小。averagePower
 */

class SFAudioRecorderViewController: UIViewController {
    
    var recorder: AVAudioRecorder?
    
    var timer: Timer?

    @IBAction func startRecording(_ sender: UIButton) {
        
        // 创建录制音频的存储路径
        let url = URL(string: "\(cachePath)/123.wav")!

        /**
         录音设置
         - AVSampleRateKey：音频采样率（采集声音的频率)
         - AVNumberOfChannelsKey：声道数
        */
        let settings = [AVSampleRateKey: 44100, AVNumberOfChannelsKey: 0]
        
        // 创建录音对象
        guard let recorder = try? AVAudioRecorder(url: url, settings: settings) else {
            print("创建录音对象时异常！")
            return
        }
        self.recorder = recorder
        
        // 开始/恢复录音
        recorder.record()
        
        // A Boolean value that indicates whether audio-level metering is enabled.
        // By default, audio level metering is off for an audio recorder.
        // Because metering uses computing resources, turn it on only if you intend to use it.
        recorder.isMeteringEnabled = true
        
        // 添加定时器，用来定时输出录音的音量大小
        addTimer()
    }
    
    @IBAction func endRecording(_ sender: Any) {
        
        /// 停止并结束录音
        recorder?.stop()
        
        // 当停止录音时需要停止定时器
        removeTimer()
    }
}

extension SFAudioRecorderViewController {
    
    func addTimer() {
        
        timer = Timer(fireAt: Date(), interval: 0.1, target: self, selector: #selector(updateMeterPower), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func removeTimer() {
        /// 删除运行循环强引用
        timer?.invalidate()
        
        /// 删除控制器强引用
        timer = nil
    }
    
    @objc
    func updateMeterPower() {
        
        // Refreshes the average and peak power values for all channels of an audio recorder.
        // 刷新audio recorder所有频道的平均值和峰值大小
        recorder?.updateMeters()
        
        // 获取第0频道的平均声音值
        let power = recorder?.averagePower(forChannel: 0)
        
        print(power)
    }
}
