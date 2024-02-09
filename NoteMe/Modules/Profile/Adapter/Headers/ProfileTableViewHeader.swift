//
//  ProfileTabelViewHeader.swift
//  NoteMe
//
//  Created by George Popkich on 29.01.24.
//

import UIKit

final class ProfileTableViewHeader: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .appBoldFont(14.0)
        label.text = "Test"
        return label
    }()
    
    var text: String? {
        get { titleLabel.text}
        set { titleLabel.text = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
