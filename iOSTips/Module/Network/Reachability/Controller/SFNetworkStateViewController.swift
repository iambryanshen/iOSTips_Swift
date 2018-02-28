//
//  SFNetworkStateViewController.swift
//  iOSTips
//
//  Created by brian on 2017/12/28.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit
import SystemConfiguration

class SFNetworkStateViewController: UIViewController {
    
    var hostReachability: Reachability!
    var internetReachability: Reachability!
    
    @IBOutlet weak var remoteHostImageView: UIImageView!
    @IBOutlet weak var remoteHostTextField: UITextField!
    
    @IBOutlet weak var internetConnectionImageView: UIImageView!
    @IBOutlet weak var internetConnectionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 监测网络
        monitorTheNetwork()
    }
}

//MARK: - monitor the network
extension SFNetworkStateViewController {
    
    func monitorTheNetwork() {
        
        // 监听网络改变的通知
        // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: NSNotification.Name("kNetworkReachabilityChangedNotification"), object: nil)
        
        let remoteHostName = "www.baidu.com"
        self.hostReachability = Reachability(hostName: remoteHostName)
        self.hostReachability.startNotifier()
        
        self.internetReachability = Reachability.forInternetConnection()
        self.internetReachability.startNotifier()
        self.updateInterfaceWithReachability(reachability: self.internetReachability)
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        
        let currentReach = notification.object as? Reachability
        updateInterfaceWithReachability(reachability: currentReach)
    }
    
    func updateInterfaceWithReachability(reachability: Reachability?) {
        
        if reachability == self.hostReachability, let reachability = reachability {
            let netStatus = reachability.currentReachabilityStatus()
            switch netStatus {
            case NotReachable:
                remoteHostImageView.image = UIImage(named: "stop")
                remoteHostTextField.text = "没有网络"
            case ReachableViaWiFi:
                remoteHostImageView.image = UIImage(named: "WWAN")
                remoteHostTextField.text = "Wifi"
            case ReachableViaWWAN:
                remoteHostImageView.image = UIImage(named: "Airport")
                remoteHostTextField.text = "蜂窝移动网络"
            default:
                break
            }
        }
        
        if reachability == self.internetReachability, let reachability = reachability {
            
            let netStatus = reachability.currentReachabilityStatus()
            switch netStatus {
            case NotReachable:
                internetConnectionImageView.image = UIImage(named: "stop")
                internetConnectionTextField.text = "没有网络"
            case ReachableViaWiFi:
                internetConnectionImageView.image = UIImage(named: "WWAN")
                internetConnectionTextField.text = "Wifi"
            case ReachableViaWWAN:
                internetConnectionImageView.image = UIImage(named: "Airport")
                internetConnectionTextField.text = "蜂窝移动网络"
            default:
                break
            }
            // 可能是wifi已连接，但不可用时生效？？？
            let connectionRequired = reachability.connectionRequired()
        }
    }
}
