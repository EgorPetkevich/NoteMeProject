//
//  SearchLocationCell.swift
//  NoteMe
//
//  Created by George Popkich on 27.03.24.
//

import UIKit
import SnapKit

final class SearchLocationCell: UITableViewCell {
    
    private lazy var content: UIView = .content()
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .SearchLocation.location
        return imageView
    }()
    
    private lazy var locationTitleLable: UILabel = {
        let label = UILabel()
        label.font = .appRegularFont(14.0)
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
    
    func setup(_ type: NearByResponseModel.Result) {
        locationTitleLable.text = type.name
    }
    
    private func setupUI() {
        self.backgroundColor = .appContentWhite
        self.addSubview(content)
        
        content.addSubview(locationImageView)
        content.addSubview(locationTitleLable)
    }
    
    private func setupConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(45.0)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.0)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(16.0)
        }
        
        locationTitleLable.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).offset(8.0)
            make.top.equalToSuperview().offset(10)
        }
    }
    
}
