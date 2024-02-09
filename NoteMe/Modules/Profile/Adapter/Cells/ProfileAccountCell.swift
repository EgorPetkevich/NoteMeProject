//
//  ProfileAccountCell.swift
//  NoteMe
//
//  Created by George Popkich on 29.01.24.
//

import UIKit
import SnapKit

final class ProfileAccountCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appSeparator
        label.font = .appFont.withSize(15.0)
        label.text = "Your e-mail:"
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(17.0)
        label.textColor = .appText
        return label
    }()
    
    var email: String? {
        get { emailLabel.text }
        set{ emailLabel.text = newValue }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(_ email: String) {
        emailLabel.text = email
    }
    
    private func setupUI() {
        self.backgroundColor = .appContentWhite
        
        addSubview(titleLabel)
        addSubview(emailLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
             
        emailLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).inset(-4)
        }
    }
    
}

