////
////  LineButton.swift
////  NoteMe
////
////  Created by George Popkich on 15.01.24.
////
//
//
import UIKit
import SnapKit

final class LineButton: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.cornerRadius = 5.0
        
        button.setTitleColor(.appText, for: .normal)
        button.setTitleColor(
            .appText.withAlphaComponent(0.75),
            for: .highlighted)
        button.titleLabel?.font = UIFont.appRegularFont(16.0)
       
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -5.0, bottom: 0.0, right: 0.0)
        return button
    }()
    

    
     lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .appSeparator
        return view
    }()
    
    
    
    init() {
        super.init(frame: .zero)
       
        commonInit()
        
    }
    
    required init?(coder: NSCoder, targer: Any, selector: Selector) {
        super.init(coder: coder)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(button)
        addSubview(separator)
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        separator.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).inset(-12.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
}

