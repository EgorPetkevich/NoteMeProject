//
//  SingInVC.swift
//  NoteMe
//
//  Created by George Popkich on 3.11.23.
//

import UIKit
import SnapKit

@objc protocol RegisterPresenterProtocol: AnyObject {
    func registerDidTap(email: String?,
                        password: String?,
                        repeatPassword: String?)
    @objc func haveAccountDidTap()
}

final class RegisterVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    private lazy var titleLabel: UILabel = .title(.Auth.singInTitle)
    
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = UIImageView(image: .General.logo)
    
    private lazy var registerButton: UIButton =
        .yellowRoundedButton(.Auth.singInRegButton)
        .withAction(self, #selector(registerDidTap))
    private lazy var iHaveAccountButton: UIButton = 
        .underlineyellowButton(.Auth.singInIHaveAccountButton)
        .withAction(presenter,
                    #selector(RegisterPresenterProtocol.haveAccountDidTap))
    
    private lazy var emailTextField: LineTextField =
    LineTextField()
        .setTitle(.Auth.singInEmailTitle)
        .setPlaceholder(.Auth.singInEmailTextField)

    private lazy var passwordTextField: LineTextField =
    LineTextField()
        .setTitle(.Auth.singInPassTitle)
        .setPlaceholder(.Auth.singInEmailTextField)
    
    private lazy var repeatPasswordTextField: LineTextField =
    LineTextField()
        .setTitle(.Auth.singInRepeatPassTitle)
        .setPlaceholder(.Auth.singInRepeatPassTextField)
    
    private var presenter: RegisterPresenterProtocol
    
    init(presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setUpUI()
        setUpConstrains()
    }
    
    private func setUpUI() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(registerButton)
        view.addSubview(iHaveAccountButton)
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        logoContainer.addSubview(logoImageView)
        
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
    
    @objc private func registerDidTap() {
        presenter.registerDidTap(
            email: emailTextField.text,
            password: passwordTextField.text,
            repeatPassword: repeatPasswordTextField.text
        )
    }
    
}

extension RegisterVC: RegisterPresenterDelegate {
    
    func keyboardFrameChanged(_ frame: CGRect) {
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
    
    func setEmailError(error: String?) {
        self.emailTextField.errorText = error
    }
    
    func setPasswordError(error: String?) {
        self.passwordTextField.errorText = error
    }
    
    func setRepeatPassError(error: String?) {
        self.repeatPasswordTextField.errorText = error
    }
    
}
