//
//  TimerPickerView.swift
//  NoteMe
//
//  Created by George Popkich on 10.03.24.
//

import UIKit
import SnapKit

@available(iOS 13.4, *)
final class TimerPickerView: UIView, UIPickerViewDelegate {
    
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    
    lazy var timerPicker: UIPickerView = {
        let datePicker = UIPickerView()
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
    
    var datePickerViewFrame: CGRect? {
        get { self.frame }
        set { self.frame = newValue ?? .null }
    }
    
    var timerPickerViewDelegate: UIPickerViewDelegate? {
        get { self.timerPicker.delegate }
        set { self.timerPicker.delegate = newValue}
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
        timerPicker.delegate = self
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
        addSubview(timerPicker)
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
        
        timerPicker.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(cancelButton.snp.bottom).offset(14.0)
            make.bottom.equalToSuperview().inset(20.0)
        }
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                 return 3
             }

             func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                 switch component {
                 case 0:
                     return 25
                 case 1, 2:
                     return 60
                 default:
                     return 0
                 }
             }

             func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
                 return pickerView.frame.size.width/3
             }

             func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                 switch component {
                 case 0:
                     return "\(row) Hour"
                 case 1:
                     return "\(row) Minute"
                 case 2:
                     return "\(row) Second"
                 default:
                     return ""
                 }
             }
             func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                 switch component {
                 case 0:
                     hour = row
                 case 1:
                     minutes = row
                 case 2:
                     seconds = row
                 default:
                     break;
                 }
             }
}

