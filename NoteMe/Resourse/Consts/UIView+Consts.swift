//
//  UIView+Consts.swift
//  NoteMe
//
//  Created by George Popkich on 26.10.23.
//

import UIKit

extension UIView {
    static func content() -> UIView {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }
    
    static func login () -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.appContentWhite
        return view
    }
    
    static func separator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }
}
