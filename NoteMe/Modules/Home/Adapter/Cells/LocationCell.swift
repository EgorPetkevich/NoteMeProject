//
//  LocationCell.swift
//  NoteMe
//
//  Created by George Popkich on 26.02.24.
//

import UIKit
import Storage

final class LocationCell: UITableViewCell {
    
    var buttonDidTap: ((_ sender: UIButton) -> Void)?
    
    private var fileManager = FileManagerService.instansce
    
    private lazy var content: UIView = .content()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .Home.location
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont(15.0)
        label.textColor = .appText
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .appRegularFont(13.0)
        label.textColor = .appText
        return label
    }()
    
    private lazy var locationImageView = UIImageView()
    
    private lazy var editButton: UIButton = 
        .editNotificationButton()
        .withAction(self, #selector(editButtonDidTap))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(_ type: LocationNotificationDTO) {
        titleLabel.text = type.title
        titleLabel.textColor = .appText
        subtitleLabel.text = type.subtitle
        locationImageView.image = takeImage(for: type.imagePathStr)
        
    }

    func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(content)
        
        content.cornerRadius = 5.0
        content.setShadow()
        content.addSubview(infoImageView)
        content.addSubview(titleLabel)
        content.addSubview(subtitleLabel)
        content.addSubview(editButton)
        content.addSubview(locationImageView)
    }
    
    private func setupConstraints() {
        
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(257.0)
        }
        
        content.snp.makeConstraints { make in
            make.height.equalTo(247.0)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.contentView.snp.top).offset(10.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.left.equalTo(infoImageView.snp.right).offset(8.0)
            make.height.equalTo(17.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.left.equalTo(infoImageView.snp.right).offset(8.0)
            make.height.equalTo(15.0)
        }
        
        infoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().offset(16.0)
            make.size.equalTo(50.0)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(infoImageView.snp.bottom).offset(8.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        editButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.right.top.equalToSuperview().inset(16.0)
        }
    }
    
    private func takeImage(for key: String) -> UIImage {
        return fileManager.read(directory: .userLocationScreenshots,
                                with: key) ?? UIImage()
        
    }
    
    @objc private func editButtonDidTap(sender: UIButton) {
        buttonDidTap?(sender)
    }
    
}

