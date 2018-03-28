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
    
    @IBOutlet weak var audioVolume: UILabel!
    
    var recorder: AVAudioRecorder?
    
    var timer: Timer?
    
    var path: String = cachePath + "123.wav"
    

    /// 按住屏幕时开始录音
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 创建录制音频的存储路径
        let url = URL(string: path)!
        /**
         录音设置
         - AVSampleRateKey：音频采样率（采集声音的频率)
         - AVNumberOfChannelsKey：声道数
         */
        let settings = [
            // 采样率：采集声音的频率
            AVSampleRateKey: NSNumber(value: 44100.0),
            // 通道数
            AVNumberOfChannelsKey: NSNumber(value: 0),
            // 编码格式
            AVFormatIDKey: NSNumber(value: Int32(kAudioFormatLinearPCM)),
            // 录音质量
            AVEncoderAudioQualityKey: NSNumber(value: Int32(AVAudioQuality.min.rawValue))
        ]
        
        // 创建录音对象
        guard let recorder = try? AVAudioRecorder(url: url, settings: settings) else {
            print("创建录音对象时异常！")
            return
        }
        self.recorder = recorder
        
        // 开始/恢复录音
        recorder.record()
        // 几秒后开始录音
        // recorder.record(atTime: <#T##TimeInterval#>)
        // 录音多久
        // recorder.record(forDuration: <#T##TimeInterval#>)
        // 几秒后开始录音多久
        // recorder.record(atTime: <#T##TimeInterval#>, forDuration: <#T##TimeInterval#>)
        
        // A Boolean value that indicates whether audio-level metering is enabled.
        // By default, audio level metering is off for an audio recorder.
        // Because metering uses computing resources, turn it on only if you intend to use it.
        recorder.isMeteringEnabled = true
        
        // 添加定时器，用来定时输出录音的音量大小
        addTimer()
    }
    
    /// 松开屏幕时结束录音
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let currentTime = recorder?.currentTime else {
            
            /// 停止并结束录音
            recorder?.stop()
            
            // 当停止录音时需要停止定时器
            removeTimer()
            
            return
        }
        
        if currentTime < 2 {
            /// 停止并结束录音
            recorder?.stop()
            
            // 当停止录音时需要停止定时器
            removeTimer()
            
            // 删除录音文件（删除文件之前一定要停止录音）
            recorder?.deleteRecording()
            
        } else {
            /// 停止并结束录音
            recorder?.stop()
            
            // 当停止录音时需要停止定时器
            removeTimer()
            
            // 把wav文件转成mp3文件，文件大小明显缩小
            let result = SFLameTool.audio(toMP3: path, isDeleteSourchFile: false)
            
            // 去路径下查看两个文件
            print(result)
        }
    }
}

//MARK: - 定时器用来监听录音音量的大小
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
        guard let power = recorder?.averagePower(forChannel: 0) else {return}
        
        // 显示录音音量的大小
        audioVolume.text = "\(power)"
    }
}
