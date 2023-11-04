//
//  UIFont+Consts.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit

extension UIFont{
    
    static var appFont: UIFont = .systemFont(ofSize: 17.0)
    static var appTitleFont: UIFont = UIFont(name: "Helvetica-Bold", size: 25)!
    
    static func appRegularFont (_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size)!
    }
    
    static func appBoldFont (_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
    
}
