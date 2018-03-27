//
//  SFPlayAudioViewController.swift
//  iOSTips
//
//  Created by brian on 2018/3/27.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFPlayAudioViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SFAudioTool.playAudioWithName(name: "m_16.wav")
    }
}
