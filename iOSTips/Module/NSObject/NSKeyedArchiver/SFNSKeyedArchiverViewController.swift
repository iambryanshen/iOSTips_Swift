//
//  SFNSKeyedArchiverViewController.swift
//  iOSTips
//
//  Created by brian on 2018/2/1.
//  Copyright © 2018年 brian. All rights reserved.
//

import UIKit

/*
 一般用来存储对象信息
 */

class SFNSKeyedArchiverViewController: UIViewController {
    
    @IBOutlet weak var personLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyedArchiverView = Bundle.main.loadNibNamed("SFKeyedArchiverView", owner: nil, options: [:])?.first as! SFKeyedArchiverView
        keyedArchiverView.backgroundColor = UIColor.red
        keyedArchiverView.frame = self.view.bounds
        keyedArchiverView.frame.size.height = keyedArchiverView.frame.height * 0.5
        keyedArchiverView.frame.origin.y = keyedArchiverView.frame.size.height
        view.addSubview(keyedArchiverView)
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        
        // 该对象通过NSKeyedArchiver的方式存储到内存中
        let person = Person()
        person.name = "BrianShen"
        person.age = 25
        
        let dog = Dog()
        dog.dogName = "wanwan"
        person.dog = dog
        
        // 拼接存储的路径
        let tempPath = NSTemporaryDirectory() + "person.data"
        
        // 使用归档的方式保存对象到内存中
        NSKeyedArchiver.archiveRootObject(person, toFile: tempPath)
    }
    
    @IBAction func fetchData(_ sender: UIButton) {
        
        // 拼接存储的路径
        let tempPath = NSTemporaryDirectory() + "person.data"
        
        // 从内存中解档保存在内存中的对象信息
        let person = NSKeyedUnarchiver.unarchiveObject(withFile: tempPath) as! Person
        personLabel.text = "\(person.name ?? "") \(person.age ?? 0) \(person.dog?.dogName ?? "")"
        print(person.name ?? "", person.age ?? 0, person.dog?.dogName ?? "")
    }
}
