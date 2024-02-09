//
//  View+Layer.swift
//  NoteMe
//
//  Created by George Popkich on 31.10.23.
//

import UIKit
extension UIView {
    
    var shadowColor: CGColor {
        get { layer.shadowColor! }
        set { layer.shadowColor = newValue }
    }
    
    var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        
    }
    
    func setShadow(_ width: CGFloat = 0.0,
                   _ height: CGFloat = 0.0,
                   _ color: UIColor = .black,
                   _ radius: CGFloat = 3.0,
                   _ opacity: Float = 0.08
                   )
    {
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func addShadow(){
           self.layer.shadowColor = UIColor.appShadow.cgColor
           self.layer.shadowOffset = CGSize(width: 2, height: 4)
           self.layer.shadowRadius = 4
           self.layer.shadowOpacity = 1
           self.layer.masksToBounds = false
    }
    
}
