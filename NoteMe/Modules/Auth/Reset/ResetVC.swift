//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by George Popkich on 3.11.23.
//

import UIKit
import SnapKit

@objc protocol ResetViewModelProtocol {
    var catchEmailError: ((String?) -> Void)? {get set}
    var keyboardFrameChanged: ((CGRect) -> Void)? { get set}
    
    func resetDidTap(email: String?)
    @objc func cancelDidTap()
}

final class ResetVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = UIView.info()
    private lazy var titleLabel: UILabel = .title(.Auth.resetPassTitle)
    private lazy var interpretLabel: UILabel = .interpret(.Auth.resetPassText, 13.0)
    
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView =
    UIImageView(image: .General.logo)
    
    private lazy var resetButton: UIButton =
        .yellowRoundedButton(.Auth.resetPassResetButton)
        .withAction(self, #selector(resetButtonDidTap))
    private lazy var cancelButton: UIButton = 
        .cancelButton(.Auth.resetPassCancelButton)
        .withAction(viewModel, #selector(ResetViewModelProtocol.cancelDidTap))
    
    private lazy var emailTextField: LineTextField =
    LineTextField()
        .setPlaceholder(.Auth.resetPassEmailTextField)

    private var viewModel: ResetViewModelProtocol
    
    init(viewModel: ResetViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setUpUI()
        setUpConstrains()
    }
    
    func bind() {
        viewModel.catchEmailError = { [weak self] errorTest in
            self?.emailTextField.setErrorText(errorTest)
        }
        viewModel.keyboardFrameChanged = { [weak self] frame in
            self?.keyboardFrameChanged(frame)
        }
    }
    
    private func setUpUI() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(resetButton)
        view.addSubview(cancelButton)
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        infoView.addSubview(interpretLabel)
        infoView.addSubview(emailTextField)
        
        logoContainer.addSubview(logoImageView)
    }
    
    private func setUpConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(resetButton.snp.centerY)
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
    
    @objc private func resetButtonDidTap() {
        viewModel.resetDidTap(email: emailTextField.text)
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
