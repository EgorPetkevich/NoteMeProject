//
//  SingInVC.swift
//  NoteMe
//
//  Created by George Popkich on 3.11.23.
//

import UIKit
import SnapKit

final class SingInVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    private lazy var titleLabel: UILabel = .title("nice_to_meet_you_title".localized)
    
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var registerButton: UIButton = .yellowRoundedButton("register_button".localized)
    private lazy var iHaveAccountButton: UIButton = .underlineyellowButton("i_have_account_button".localized)
    
    private lazy var emailTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "email_label".localized
        textField.placeholder = "enter_email_text_field".localized
        return textField
    }()
    
    private lazy var passwordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "password_label".localized
        textField.placeholder = "enter_password_text_field".localized
        return textField
    }()
    
    private lazy var repeatPasswordTextField: LineTextField = {
        let textField = LineTextField()
        textField.title = "repeat_password_label".localized
        textField.placeholder = "repeat_password_text_field".localized
        return textField
    }()
    
    override func viewDidLoad() {
        setUpUI()
        setUpConstrains()
    }
    
    private func setUpUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(registerButton)
        view.addSubview(iHaveAccountButton)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        infoView.addSubview(emailTextField)
        infoView.addSubview(passwordTextField)
        infoView.addSubview(repeatPasswordTextField)
    }
    
    private func setUpConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(registerButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).inset(-68.0)
            make.height.equalTo(29.0)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
         
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-16.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(repeatPasswordTextField.snp.top).inset(-20.0)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(20.0)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(iHaveAccountButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        iHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
        }
    }
    
}
