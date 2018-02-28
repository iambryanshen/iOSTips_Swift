//
//  SFJSONExampleTableViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/4.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit

class SFJSONExampleTableViewController: UITableViewController {

    var jsonExampleModelArray: [SFJSONExampleModel] = [SFJSONExampleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SFJSONExampleCell", bundle: nil), forCellReuseIdentifier: "SFJSONExampleCell")
        
        request()
    }
}

//MARK: - Request Data
extension SFJSONExampleTableViewController {
    func request() {
        URLSession.shared.dataTask(with: videoURL!) { (data, response, error) in
            let result = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
            let array: [[String: Any]] = result?["videos"] as! [[String: Any]]
            var tempArray: [SFJSONExampleModel] = [SFJSONExampleModel]()
            for dict in array {
                let jsonExampleModel = SFJSONExampleModel(dict: dict)
                tempArray.append(jsonExampleModel)
            }
            self.jsonExampleModelArray = tempArray
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }.resume()
    }
}

//MARK: - UITableViewDataSource
extension SFJSONExampleTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonExampleModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SFJSONExampleCell", for: indexPath) as! SFJSONExampleCell
        cell.jsonExampleModel = self.jsonExampleModelArray[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SFJSONExampleTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: self.jsonExampleModelArray[indexPath.row].url!, relativeTo: baseURL)
        let playerVC = AVPlayerViewController()
        playerVC.player = AVPlayer(url: url!)
        self.present(playerVC, animated: true, completion: nil)
    }
}
