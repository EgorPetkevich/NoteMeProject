//
//  LineTextView.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit
import SnapKit

protocol LineTextViewDelegate: AnyObject {
    func lineTextView(_ textField: LineTextView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

final class LineTextView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appBoldFont(13.0)
        label.textColor = .appText
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .appGrayText
        textView.font = UIFont.appRegularFont(15.0)
        textView.textAlignment = .left
        textView.setBorder(width: 1.0, color: .appText)
        textView.delegate = self
        return textView
    }()
    
    var title: String? {
        get{ titleLabel.text }
        set{ titleLabel.text = newValue }
    }
    
    var placeholder: String? {
        didSet {
            textView.text = placeholder
        }
    }
    
//    var placeholder: String? {
//        get{ placeholderComment}
//        set{ placeholderComment = newValue }
//    }
    
    var text: String? {
        get { textView.text }
        set { textView.text = newValue }
    }
    
    var textColor: UIColor? {
        get { textView.textColor }
        set { textView.textColor = newValue }
    }
    
    @available(iOS 17.0, *)
    var borderStyle: UITextView.BorderStyle? {
        get { textView.borderStyle }
        set { textView.borderStyle = newValue ?? .none }
    }

    weak var delegate: LineTextViewDelegate?
    
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textView)
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4.0)
            make.height.equalTo(68.0)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
}

extension LineTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.text == self.placeholder {
            self.text = ""
            self.textColor = .appText
        }
    }
    
    func textView(_ textView: UITextView, 
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "/n" {
            self.textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text == "" {
            self.text = placeholder
            textColor = .appSeparator
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?
            .lineTextView(self,
                          shouldChangeCharactersIn: range,
                          replacementString: string) ?? true
    }
    
    private func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

