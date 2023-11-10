//
//  LoginVC.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    private lazy var titleLabel: UILabel = .title("welcom_back_title".localized)
    
    private lazy var logoImageView: UIImageView = UIImageView(image: .General.logo)
    
    private lazy var loginButton: UIButton = 
        .yellowRoundedButton("login_button".localized)
    private lazy var newAccountButton: UIButton = .underlineyellowButton("new_account_button".localized)
    private lazy var forgotPasswordButton: UIButton = .underlineGrayButton("forgot_password_button".localized)
    
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
    
    override func viewDidLoad() {
        setUpUI()
        setUpConstrains()
    }
    
    private func setUpUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        infoView.addSubview(emailTextField)
        infoView.addSubview(passwordTextField)
        infoView.addSubview(forgotPasswordButton)
    }
    
    private func setUpConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(loginButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(72.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoView.snp.top).inset(-8.0)
            make.height.equalTo(29.0)
        }
        
        infoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16.0)
        }
         
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
            make.bottom.equalTo(passwordTextField.snp.top).inset(-16.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.bottom.equalTo(forgotPasswordButton.snp.top).inset(-20.0)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(16.0)
            make.height.equalTo(17.0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(newAccountButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        newAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
        }
    }
    
}
