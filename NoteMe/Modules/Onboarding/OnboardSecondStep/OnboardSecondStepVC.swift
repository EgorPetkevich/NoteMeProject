//
//  OnboardingSecondStepVC.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import UIKit

@objc protocol OnboardSecondStepViewModelProtocol {
    @objc func doneDidTap()
    func dissmissedByUser()
}

final class OnboardSecondStepVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    private lazy var titleLabel: UILabel = .title(.Onboarding.secondStepTitle)
    private lazy var interpretTextLabel: UILabel = {
        let label = UILabel()
        let text = "You can use 3 types of notifications <p style=\"margin-left: 8px;\"> <b>&#8226; Calendar -</b> choose the date, when you want to receive notification. <br><b>&#8226; Location -</b> hoose the region and notification will come after you enter it. <br><b>&#8226; Timer -</b>  set timer and after the selected period, you will receive the notification."
        label.attributedText = .parse(html: text, font: .appFont.withSize(13))
        label.numberOfLines = .zero 
        return label
    }()
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = UIImageView(image: .General.logo)
    
    private lazy var infoSetContainer: UIView = UIView()
    private lazy var infoImageView: UIImageView = UIImageView(image: .Onboarding.infoSet)
    
    private lazy var doneButton: UIButton =
        .yellowRoundedButton(.Onboarding.secondStepDoneButton)
        .withAction(viewModel,
                    #selector(OnboardSecondStepViewModelProtocol.doneDidTap))
    
    private var viewModel: OnboardSecondStepViewModelProtocol?
    
    init(viewModel: OnboardSecondStepViewModelProtocol? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstrains()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel?.dissmissedByUser()
    }
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(doneButton)
        
        contentView.addSubview(logoContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(infoSetContainer)
        
        infoView.addSubview(interpretTextLabel)
        
        logoContainer.addSubview(logoImageView)
        infoSetContainer.addSubview(infoImageView)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(doneButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        
        infoSetContainer.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(infoView.snp.bottom)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(96.0)
        }
        
        infoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(157.0)
            make.width.equalTo(180.0)
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
        
        interpretTextLabel.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalToSuperview().inset(16.0)
            make.height.equalTo(105.0)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }
    
}

