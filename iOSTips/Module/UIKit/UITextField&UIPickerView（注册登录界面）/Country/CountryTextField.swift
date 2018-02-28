//
//  CountryTextField.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class CountryTextField: UITextField {
    
    // 懒加载数据
    lazy var countryArray: [CountryModel] = {
        
        let flagsPath = Bundle.main.path(forResource: "flags", ofType: "plist") ?? ""
        let flagsArray = NSArray(contentsOfFile: flagsPath) as! [[String: String]]
        
        var countryArray: [CountryModel] = [CountryModel]()
        for dict in flagsArray {
            // 字典数据转换成模型数据
            let countryModel = CountryModel.countryModelWithDict(dict: dict)
            countryArray.append(countryModel)
        }
        return countryArray
    }()
    
    // 同时重写是哪个初始化方法设置inputView，保证UITextField通过任何方法创建都能更改inputView
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInputView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInputView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInputView()
    }
    
    func setupInputView() {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        self.inputView = pickerView
    }
    
    func setupInitContent() {
        self.text = countryArray[0].name
    }
}

extension CountryTextField: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

extension CountryTextField: UIPickerViewDelegate {
    
    // Column Width
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.bounds.width
    }
    
    // Row Height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let flagView = Bundle.main.loadNibNamed("FlagView", owner: nil, options: nil)?.first as! FlagView
        flagView.countryModel = countryArray[row]
        return flagView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = countryArray[row].name
    }
}
