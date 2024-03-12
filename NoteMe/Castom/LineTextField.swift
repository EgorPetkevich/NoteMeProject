//
//  LineTextField.swift
//  NoteMe
//
//  Created by George Popkich on 31.10.23.
//

import UIKit
import SnapKit

protocol LineTextFieldDelegate: AnyObject {
    func lineTextField(_ textField: LineTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

final class LineTextField: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appBoldFont(13.0)
        label.textColor = .appText
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .appText
        textField.font = UIFont.appRegularFont(15.0)
        textField.textAlignment = .left
        textField.delegate = self
        return textField
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .appText
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appBoldFont(12.0)
        label.textColor = .appRed
        label.textAlignment = .left
        return label
    }()
    
    var title: String? {
        get{ titleLabel.text }
        set{ titleLabel.text = newValue }
    }
    
    var errorText: String? {
        get{ errorLabel.text }
        set{ errorLabel.text = newValue }
    }
    
    var placeholder: String? {
        get{ textField.placeholder}
        set{ textField.placeholder = newValue }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var borderStyle: UITextField.BorderStyle? {
        get { textField.borderStyle }
        set { textField.borderStyle = newValue ?? .none }
    }
    
    var setSeparator: UIColor? {
        get { separator.backgroundColor }
        set { separator.backgroundColor = newValue}
    }
    
    var textFieldInputView: UIView? {
        get { textField.inputView }
        set { textField.inputView = newValue }
    }
    
    
    //    var delegate: UITextFieldDelegate? {
    //        get { textField.delegate }
    //        set { textField.delegate = newValue }
    //    }
    weak var delegate: LineTextFieldDelegate?
    
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    init(_ comment: Any? = nil) {
        super.init(frame: .zero)
        commentInit()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(separator)
        addSubview(errorLabel)
    }
    
    private func setupCommentUI() {
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func commentInit() {
        setupCommentUI()
        setupCommentConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).inset(-4.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
        errorLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).inset(-4.0)
        }
    }
    
    private func setupCommentConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.height.equalTo(68.0)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
}

extension LineTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.lineTextField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
