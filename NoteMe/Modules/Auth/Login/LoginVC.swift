//
//  LoginVC.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = UIView.content()
    private lazy var logView: UIView = UIView.login()
    private lazy var welcomeBackLable: UILabel = UILabel.title("Welcome back!")
    private lazy var emailLabel = UILabel.bold("Email", 13.0)
    private lazy var passwordLabel = UILabel.bold("Password", 13.0)
    private lazy var emailSeparator : UIView = UIView.separator()
    private lazy var passwordSeparator: UIView = UIView.separator()
    private lazy var logoImageView: UIImageView =
            UIImageView(image: .General.logo)
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Enter E-mail"
        textField.textColor = UIColor.appHighlighted
        textField.font = UIFont.appRegularFont(15.0)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Enter Password"
        textField.textColor = UIColor.appHighlighted
        textField.font = UIFont.appRegularFont(15.0)
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.setTitleColor(UIColor.appHighlighted, for: .normal)
        button.titleLabel?.font = UIFont.appBoldFont(15.0)
        button.underline()
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.appYellow
        button.titleLabel?.font = UIFont.appBoldFont(17.0)
        return button
    }()
    
    private lazy var newAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Account", for: .normal)
        button.setTitleColor(UIColor.appYellow, for: .normal)
        button.titleLabel?.font = UIFont.appBoldFont(17.0)
        button.underline()
        return button
    }()
    
    
    
    override func viewDidLoad() {
        setUpUI()
        setUpConstrains()
    }
    
    private func setUpUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(welcomeBackLable)
        contentView.addSubview(logView)
        logView.addSubview(emailLabel)
        logView.addSubview(passwordLabel)
        logView.addSubview(forgotPasswordButton)
        logView.addSubview(emailTextField)
        logView.addSubview(passwordTextField)
        logView.addSubview(emailSeparator)
        logView.addSubview(passwordSeparator)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)
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
        welcomeBackLable.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(-72.0)
            make.centerX.equalToSuperview()
        }
        logView.snp.makeConstraints { make in
            make.top.equalTo(welcomeBackLable.snp.bottom).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(16.0)
            
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(logView.snp.top).inset(16.0)
            make.left.equalTo(logView.snp.left).inset(16.0)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-4.0)
            make.left.right.equalTo(logView).inset(16.0)
        }
        emailSeparator.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-4.0)
            make.left.right.equalTo(logView).inset(16.0)
            make.height.equalTo(1.0)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-20.0)
            make.left.equalTo(logView.snp.left).inset(16.0)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-4.0)
            make.left.right.equalTo(logView).inset(16.0)
        }
        passwordSeparator.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-4.0)
            make.left.right.equalTo(logView).inset(16.0)
            make.height.equalTo(1.0)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-24.0)
            make.bottom.equalTo(logView.snp.bottom).inset(16.0)
            make.left.equalTo(logView.snp.left).inset(16.0)
        }
        newAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(16.0)
            make.left.right.equalTo(view).inset(135.5)
        }
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(newAccountButton.snp.top).inset(-8.0)
            make.left.right.equalTo(view).inset(20.0)
            make.height.equalTo(45.0)
        }
        
    }
}
