//
//  DatePickerView.swift
//  NoteMe
//
//  Created by George Popkich on 12.02.24.
//

import UIKit
import SnapKit

@available(iOS 13.4, *)
final class DatePickerView: UIView {
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .appInfoWhite
        return datePicker
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(
            .appYellow.withAlphaComponent(0.75),
            for: .highlighted)
        button.titleLabel?.font = UIFont.appRegularFont(15.0)
        return button
    }()
    
    lazy var selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(
            .appYellow.withAlphaComponent(0.75),
            for: .highlighted)
        button.titleLabel?.font = UIFont.appBoldFont(15.0)
        return button
    }()
    
    var datePickerMode: UIDatePicker.Mode? {
        get { datePicker.datePickerMode }
        set { datePicker.datePickerMode = newValue ?? .date }
    }
    
    var datePickerViewFrame: CGRect? {
        get { self.frame }
        set { self.frame = newValue ?? .null }
    }
    
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .appBackground
        addSubview(datePicker)
        addSubview(cancelButton)
        addSubview(selectButton)
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.0)
            make.height.equalTo(17.0)
            make.left.equalToSuperview().inset(20.0)
        }
        
        selectButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.0)
            make.height.equalTo(17.0)
            make.right.equalToSuperview().inset(20.0)
        }
        
        datePicker.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(cancelButton.snp.bottom).offset(14.0)
            make.bottom.equalToSuperview().inset(20.0)
        }
    }
    
}
