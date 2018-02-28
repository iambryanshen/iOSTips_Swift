//
//  CityTextField.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class CityTextField: UITextField {
    
    // 懒加载数据，数据从本地plist文件获取
    lazy var provinceArray: [ProvinceModel] = {
        let path = Bundle.main.path(forResource: "provinces", ofType: "plist") ?? ""
        let provinces = NSArray(contentsOfFile: path) as! [[String: Any]]
        var provinceArray = [ProvinceModel]()
        for province in provinces {
            let provinceModel = ProvinceModel.provinceModelWithDict(dict: province)
            provinceArray.append(provinceModel)
        }
        return provinceArray
    }()
    
    // 当前选中的省份
    var currentSelectedProvinceIndex: Int = 0
    
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
    
    // 遵守TextFieldProtocol协议，实现协议方法：用来点击textField时显示的内容
    func setupInitContent() {
        let provinceName = provinceArray[0].name ?? ""
        let cityName: String! = provinceArray[0].cities?[0] as? String
        self.text = provinceName + "  " + cityName
    }
}

extension CityTextField: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinceArray.count
        } else {
            guard let cityArray = provinceArray[currentSelectedProvinceIndex].cities else {return 0}
            return cityArray.count
        }
    }
}

extension CityTextField: UIPickerViewDelegate {
    
    // Column Width
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width * 0.5
    }
    
    // Row Height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return provinceArray[row].name ?? ""
        } else {
            return provinceArray[currentSelectedProvinceIndex].cities?[row] as? String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentSelectedProvinceIndex = row
            pickerView.reloadAllComponents()
            // 默认城市滚动后选中第一个
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
        
        // 选中城市后，设置城市的内容到UITextField上
        let provinceName = provinceArray[currentSelectedProvinceIndex].name ?? ""
        let selectedRow = pickerView.selectedRow(inComponent: 1)
        guard let cityName = provinceArray[currentSelectedProvinceIndex].cities?[selectedRow] as? String else {
            return
        }
        self.text = provinceName + "  " + cityName
    }
}
