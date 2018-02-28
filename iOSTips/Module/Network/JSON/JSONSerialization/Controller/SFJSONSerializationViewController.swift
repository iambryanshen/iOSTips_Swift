//
//  SFJSONViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/4.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

class SFJSONSerializationViewController: UIViewController {

    @IBOutlet weak var jsonToSwiftLabel: UILabel!
    @IBOutlet weak var swiftToJsonLabel: UILabel!
    
    @IBAction func jsonToSwift(_ sender: UIButton) {
        jsonToSwift()
    }
    @IBAction func swiftToJson(_ sender: UIButton) {
        swiftToJson()
    }
}

extension SFJSONSerializationViewController {
    func jsonToSwift() {
        URLSession.shared.dataTask(with: videoURL!) { (data, response, error) in
            let result = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if let resultDis = result as? [String: Any] {
                print(resultDis)
            }
            
            if let resultString = String(bytes: data!, encoding: String.Encoding.utf8) {
                OperationQueue.main.addOperation {
                    self.jsonToSwiftLabel.text = resultString
                }
            }
        }.resume()
    }
    
    func swiftToJson() {
        let dict: [String : Any] = ["name": "brian", "age": 25]
        
        // Returns a Boolean value that indicates whether a given object can be converted to JSON data.
        if !JSONSerialization.isValidJSONObject(dict) {
            return
        }
        
        //  JSONSerialization.WritingOptions.prettyPrinted：对结果排版
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        swiftToJsonLabel.text = String(data: jsonData!, encoding: String.Encoding.utf8) ?? ""
        print(String(data: jsonData!, encoding: String.Encoding.utf8) ?? "")
    }
}
