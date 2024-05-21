//
//  ProfileMapCell.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit
import SnapKit

final class ProfileMapCell: UITableViewCell {
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView(image: .Profile.location)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mapLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(17.0)
        label.textColor = .appText
        label.text = "Map"
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
    
    private func setupUI() {
        self.backgroundColor = .appContentWhite
        
        addSubview(mapLabel)
        addSubview(locationImageView)
    }
    
    private func setupConstraints() {
        locationImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(16.0)
            make.height.equalTo(23.0)
            make.width.equalTo(16.0)
        }
             
        mapLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).offset(12.0)
            make.top.equalToSuperview().inset(20.0)
        }
    }
    
}
