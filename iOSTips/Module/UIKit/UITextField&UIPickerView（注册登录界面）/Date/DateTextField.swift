//
//  DateTextField.swift
//  注册界面
//
//  Created by brian on 2017/12/3.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

class DateTextField: UITextField {

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
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "zh")
        datePicker.addTarget(self, action: #selector(setContent(datePicker:)), for: .valueChanged)
        self.inputView = datePicker
    }
    
    func setupInitContent() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        self.text = dateFormatter.string(from: currentDate)
    }
}

extension DateTextField {
    
    // DatePicker值发生改变时调用
    @objc func setContent(datePicker: UIDatePicker) {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        self.text = dateFormatter.string(from: date)
    }
}
