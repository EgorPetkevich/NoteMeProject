//
//  NotificationFilterCell.swift
//  NoteMe
//
//  Created by George Popkich on 13.03.24.
//

import UIKit
import SnapKit

final class NotificationFilterCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appRegularFont(17.0)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            setSelectedUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with type: NotificationFilterType) {
        titleLabel.text = type.title
    }
    
    private func setupUI() {
        self.backgroundColor = .appDarkGray
        self.cornerRadius = 5.0
        self.addSubview(titleLabel)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setSelectedUI() {
        if isSelected {
            self.backgroundColor = .appYellow
            titleLabel.font = .appBoldFont(17.0)
        } else {
            self.backgroundColor = .appDarkGray
            titleLabel.font = .appRegularFont(17.0)
        }
    }
    
}
