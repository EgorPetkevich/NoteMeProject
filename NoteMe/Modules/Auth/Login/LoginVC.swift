//
//  LoginVC.swift
//  NoteMe
//
//  Created by George Popkich on 24.10.23.
//

import UIKit
import SnapKit

@objc protocol LoginViewModelProtocol: AnyObject {
    var catchEmailError: ((String?) -> Void)? { get set }
    var catchPasswordError: ((String?) -> Void)? { get set}
    var keyboardFrameChanged: ((CGRect) -> Void)? { get set}
    
    func loginDidTap(email: String?, password: String?)
    @objc func newAccountDidTap()
    func forgotPasswordDidTap(email: String?)
}

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    
    private lazy var titleLabel: UILabel = .title(.Auth.logTitle)
    
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = UIImageView(image: .General.logo)
    
    private lazy var loginButton: UIButton = 
        .yellowRoundedButton(.Auth.logLoginButton)
        .withAction(self, #selector(loginDidTap))
    private lazy var newAccountButton: UIButton =
        .underlineyellowButton(.Auth.logNewAccountButton)
        .withAction(viewModel,
                    #selector(LoginViewModelProtocol.newAccountDidTap))
    private lazy var forgotPasswordButton: UIButton =
        .underlineGrayButton(.Auth.logForgotPassButton)
        .withAction(self, #selector(forgotPasswordDidTap))
    
    private lazy var emailTextField: LineTextField =
    LineTextField()
        .setTitle(.Auth.logEmailTitle)
        .setPlaceholder(.Auth.logEmailTextField)
    
    private lazy var passwordTextField: LineTextField =
    LineTextField()
        .setTitle(.Auth.logPassTitle)
        .setPlaceholder(.Auth.logPassTextField)
        
    private var viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        setupConstrains()
    }
    
    private func bind() {
        viewModel.catchEmailError = { [weak self] errorText in
            self?.emailTextField.setErrorText(errorText)
        }
        viewModel.catchPasswordError = { [weak self] errorText in
            self?.passwordTextField.setErrorText(errorText)
        }
        viewModel.keyboardFrameChanged = { [weak self] frame in
            self?.keyboardFrameChanged(frame)
        }
    }
    
    private func setup() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        infoView.addSubview(emailTextField)
        infoView.addSubview(passwordTextField)
        infoView.addSubview(forgotPasswordButton)
        
        logoContainer.addSubview(logoImageView)
        
        view.addGesture(self, action: #selector(dismissKeyboard))
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(loginButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
    
    @objc private func loginDidTap() {
        viewModel.loginDidTap(email: emailTextField.text,
                              password: passwordTextField.text)
    }
    
    
    @objc private func forgotPasswordDidTap() {
        viewModel.forgotPasswordDidTap(email: emailTextField.text)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func keyboardFrameChanged(_ frame: CGRect) {
        let maxY = infoView.frame.maxY + contentView.frame.minY + 16.0
        let keyboardY = frame.minY - 16.0
        
        if maxY > keyboardY {
            let diff = maxY - keyboardY
            UIView.animate(withDuration: 0.25) {
                self.infoView.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(-diff)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
