//
//  PopSelectionCell.swift
//  NoteMe
//
//  Created by George Popkich on 15.02.24.
//

import UIKit

final class PopSelectionCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupEdit(_ type: EditNotificationRows) {
        titleLabel.text = type.title
        titleLabel.textColor = .appText
        iconImageView.image = type.icon
    }
    
    func setupNotifications(_ type: NotificationsRows) {
        titleLabel.text = type.title
        titleLabel.textColor = .appText
        iconImageView.image = type.icon
    }
    
    func setupUI() {
        self.backgroundColor = .appContentWhite
        
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(16.0)
            make.leading.equalToSuperview().inset(16.0)
            make.verticalEdges.equalToSuperview().inset(12.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(-8.0)
            make.verticalEdges.equalToSuperview().inset(12.0)
        }
    }
    
}

