//
//  SFSystemPhotoViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/5.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Photos

class SFSystemPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        
        // 获取系统权限授权信息（是否获取到相册权限）
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("用户已经授权访问相册")
        case .denied:
            print("用户已经拒绝访问相册")
        case .notDetermined:
            print("用户还没有决定是否允许访问相册")
            // 申请获取系统相册权限
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("用户已授权访问相册")
                case .denied:
                    print("用户已拒绝访问相册")
                case .notDetermined:
                    print("用户还没决定是否可以访问相册")
                case .restricted:
                    print("访客模式，无法访问相册")
                }
            }
            break
        case .restricted:
            print("客户端未被授权访问硬件的媒体类型。用户不能改变客户机的状态,可能由于活跃的限制,如家长控制")
            break
        }
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            print("支持访问相机")
        } else {
            print("相机使用中")
        }
        
        // 弹出本地相册（该操作也会去获取系统权限）
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true) {
            print("present")
        }
    }
}

extension SFSystemPhotoViewController: UIImagePickerControllerDelegate {
    
    // 系统相册中选中某一张图片时调用
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true) {
            print("dismiss")
        }
    }
    
    // 系统相册点击右上角取消时调用
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            print("dismiss")
        }
    }
}

extension SFSystemPhotoViewController: UINavigationControllerDelegate {
    
}
