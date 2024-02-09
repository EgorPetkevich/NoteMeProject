//
//  ProfileSettingsCell.swift
//  NoteMe
//
//  Created by George Popkich on 29.01.24.
//

import Foundation
import UIKit

final class ProfileSettingsCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(14.0)
        label.textColor = .appText
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(12.0)
        label.textColor = .appGrayText
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(_ type: ProfileSettingsRows) {
        titleLabel.text = type.title
        titleLabel.textColor = type == .logout ? .appRed : .appText
        iconImageView.image = type.icon
        statusLabel.text = type.infoText
    }
    
    func setupUI() {
        self.backgroundColor = .appContentWhite
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(statusLabel)
    }
    
    private func setupConstraints() {
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(16.0)
            make.leading.equalToSuperview().inset(16.0)
            make.verticalEdges.equalToSuperview().inset(12.0)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16.0)
            make.verticalEdges.equalToSuperview().inset(12.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(-8.0)
            make.verticalEdges.equalToSuperview().inset(12.0)
        }
    }
    
}
