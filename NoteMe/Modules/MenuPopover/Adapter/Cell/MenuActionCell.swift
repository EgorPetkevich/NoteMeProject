//
//  MenuActionCell.swift
//  NoteMe
//
//  Created by George Popkich on 27.02.24.
//

import UIKit

protocol MenuActionItem {
    var title: String { get }
    var icon: UIImage? { get }
}

final class MenuActionCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .appText
        label.font = .appRegularFont(16.0)
        return label
    }()
    
    private lazy var iconView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(_ item: MenuActionItem) {
        titleLabel.text = item.title
        iconView.image = item.icon
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconView)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16.0)
        }
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(24.0)
            make.left.equalTo(self.titleLabel.snp.right).offset(8.0)
            make.right.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        }
    }
    
}
