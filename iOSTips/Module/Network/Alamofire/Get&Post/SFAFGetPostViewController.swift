//
//  SFAFGetPostViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/9.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Alamofire

class SFAFGetPostViewController: UIViewController {
    
    @IBOutlet weak var getLoginStatusLabel: UILabel!
    
    @IBOutlet weak var postLoginStatusLabel: UILabel!
    
    @IBAction func get(_ sender: UIButton) {
        
        Alamofire.request("http://120.25.226.186:32812/login", method: HTTPMethod.get, parameters: ["username": "520it", "pwd": "520it", "type": "JSON"]).response { (response) in
            if let data = response.data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: String]
                    let resultString = jsonData["success"] ?? "序列化失败"
                    self.getLoginStatusLabel.text = resultString
                } catch let errorMsg {
                    print(errorMsg)
                }
            }
        }
    }
    
    @IBAction func post(_ sender: UIButton) {
        
        Alamofire.request("http://120.25.226.186:32812/login", method: HTTPMethod.post, parameters: ["username": "520it", "pwd": "520it", "type": "JSON"]).response { (response) in
            if let data = response.data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: String]
                    let resultString = jsonData["success"] ?? "序列化失败"
                    self.postLoginStatusLabel.text = resultString
                } catch let errorMsg {
                    print(errorMsg)
                }
            }
        }
    }
}
