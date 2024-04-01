//
//  UIView+Consts.swift
//  NoteMe
//
//  Created by George Popkich on 26.10.23.
//

import UIKit
import SnapKit

extension UIView {
    
    static func content() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.appContentWhite
        return view
    }
    
    static func info() -> UIView {
        let view = UIView()
        view.cornerRadius = 5.0
        view.backgroundColor = UIColor.appInfoWhite
        view.setShadow()
        return view
    }
    
    static func separator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }
    
    static func placesNotFoundView() -> UIView {
        let view = UIView()
        let grayView = UIView()
        let label = UILabel()
        let imageView = UIImageView()
        
        view.backgroundColor = .clear
        
        label.text = "Not Places found"
        label.font = .appRegularFont(14.0)
        label.textColor = .appGrayText
        
        grayView.backgroundColor = .appGrayText
        grayView.cornerRadius = 5.0
        
        imageView.image = .location
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(label)
        view.addSubview(grayView)
        
        grayView.addSubview(imageView)
        
        grayView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(50.0)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(8.0)
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(20.0)
        }
        
        return view
    }
    
}
