//
//  UIColor+Consts.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit

extension UIColor {
    convenience init(_ r: UInt8, _ g: UInt8, _ b: UInt8, _ a: CGFloat){
        self.init(red: CGFloat(r) / 256.0,
                  green: CGFloat(g) / 256.0,
                  blue: CGFloat(b) / 256.0,
                  alpha: CGFloat(a))
        
    }
    
    static var appYellow: UIColor =  .init(255, 232, 26, 1)
    static var appBlack: UIColor = .init(40, 40, 40, 1)
    static var appGray: UIColor = .init(242, 242, 242, 1)
    static var appRed: UIColor = .init(241, 63, 63, 1)
}
