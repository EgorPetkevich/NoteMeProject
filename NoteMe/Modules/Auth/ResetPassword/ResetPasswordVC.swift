//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by George Popkich on 3.11.23.
//

import UIKit
import SnapKit

final class ResetPasswordVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = UIView.info()
    private lazy var titleLabel: UILabel = .title("reset_password_title".localized)
    private lazy var interpretLabel: UILabel = .interpret("interpret_label_reset_password".localized, 13.0)
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var resetButton: UIButton = .yellowRoundedButton("reset_button".localized)
    private lazy var cancelButton: UIButton = .cancelButton()
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.placeholder = "enter_email_text_field".localized
        return textField
    }()
    
    
    override func viewDidLoad() {
        setUpUI()
        setUpConstrains()
    }
    
    private func setUpUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(resetButton)
        view.addSubview(cancelButton)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        infoView.addSubview(interpretLabel)
        infoView.addSubview(emailTextField)
    }
    
    private func setUpConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(resetButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).inset(-122.0)
            make.height.equalTo(29.0)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        interpretLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(emailTextField.snp.top).inset(-8.0)
        }
         
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(24.0)
        }
        
        resetButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }
    
}
