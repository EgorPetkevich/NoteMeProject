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
        return label
    }
    
    static func bold(_ text: String, _ textSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.appBoldFont(textSize)
        return label
    }
    
    static func regular(_ text: String, _ textSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.appRegularFont(textSize)
        return label
    }
}
