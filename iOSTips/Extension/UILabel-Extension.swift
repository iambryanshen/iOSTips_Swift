//
//  UILabel-Extension.swift
//  iOSTips
//
//  Created by brian on 2017/12/18.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

extension UILabel {
    var sf : UILabelExtension {
        return UILabelExtension(label: self)
    }
}

struct UILabelExtension {
    
    internal let label : UILabel
    
    internal init(label: UILabel) {
        self.label = label
    }
    
    func changeLabelRowSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
        guard let content = label.text else {return}
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: content)
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (content.count)))
        attributedString.addAttribute(NSAttributedStringKey.kern, value: wordSpace, range: NSMakeRange(0, (content.count)))
        label.attributedText = attributedString
        label.sizeToFit()
    }
    
    func specifiesTheNumberOfWordsToDisplay(number: Int) {
        guard let content = label.text else {return}
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: content)
        if content.count < number {return}
        attributedString.deleteCharacters(in: NSMakeRange(number, content.count - number))
        label.attributedText = attributedString
        label.sizeToFit()
    }
}
