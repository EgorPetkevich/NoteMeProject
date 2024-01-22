//
//  UILabel+Consts.swift
//  NoteMe
//
//  Created by George Popkich on 26.10.23.
//

import UIKit

extension UILabel {
    
    static func title(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.appTitleFont
        label.textColor = .appText
        return label
    }
    
    static func bold(_ text: String, _ textSize: CGFloat, _ textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.appBoldFont(textSize)
        return label
    }
    
    static func regular(_ text: String, _ textSize: CGFloat, _ textColor: UIColor = .appText) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.appRegularFont(textSize)
        return label
    }
    
    static func interpret(_ text: String, _ textSize: CGFloat = 13.0, _ numOfLines: Int = 2) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .appText
        label.font = UIFont.appRegularFont(textSize)
        label.numberOfLines = numOfLines
        return label
    }
    
    static func interpretAttrText(_ attrText: NSMutableAttributedString, _ numOfLines: Int = 7 ) -> UILabel {
        let label = UILabel()
        label.textColor = .appText
        label.attributedText = attrText
        label.numberOfLines = numOfLines
        return label
    }
    
}
