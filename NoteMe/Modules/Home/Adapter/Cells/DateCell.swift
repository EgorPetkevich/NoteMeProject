//
//  CalendarCell.swift
//  NoteMe
//
//  Created by George Popkich on 26.02.24.
//

import UIKit
import Storage
import SnapKit


final class DateCell: UITableViewCell {
    
    var buttonDidTap: ((_ sender: UIButton) -> Void)?
    
    private lazy var content: UIView = .content()
    
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
    
    private lazy var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.cornerRadius = 5.0
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont(25.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .appYellow
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont(15.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
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
    
    func setup(_ type: DateNotificationDTO) {
        titleLabel.text = type.title
        titleLabel.textColor = .appText
        subtitleLabel.text = type.subtitle
        set(date: type.targetDate)
    }

    func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(content)
        
        content.cornerRadius = 5.0
        content.setShadow()
        content.addSubview(dateView)
        content.addSubview(titleLabel)
        content.addSubview(subtitleLabel)
        content.addSubview(editButton)
        
        dateView.addSubview(dateLabel)
        dateView.addSubview(monthLabel)
    }
    
    private func setupConstraints() {
        
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(92)
        }
        
        content.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.contentView.snp.top).offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.left.equalTo(dateView.snp.right).offset(8.0)
            make.height.equalTo(17.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.left.equalTo(dateView.snp.right).offset(8.0)
            make.height.equalTo(15.0)
        }
        
        dateView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().offset(16.0)
            make.size.equalTo(50.0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(11)
            make.top.equalToSuperview().inset(4)
        }
               
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(5)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(4)
        }
        
        editButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.right.top.equalToSuperview().inset(16.0)
        }
    }
    
    @objc private func editButtonDidTap(sender: UIButton) {
        buttonDidTap?(sender)
    }
    
    private func set(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        dateLabel.text = formatter.string(from: date)
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: date)
    }
    
}

