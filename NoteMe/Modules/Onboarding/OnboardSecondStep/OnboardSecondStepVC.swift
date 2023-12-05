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
    private lazy var interpretTextLabel: UILabel = .interpretAttrText(makeText())
    
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
    
    func makeText() ->  NSMutableAttributedString {
        let text = String.Onboarding.secondStepInterpretText

        var attributedString = NSMutableAttributedString(string: text)

        makeTextAttributes(location: 0, length: attributedString.length, attributedString: &attributedString)
        makeBulletAttributes(word: .Onboarding.secondStepCalendar, text: text, attributedString: &attributedString)
        makeBulletAttributes(word: .Onboarding.secondStepLocation, text: text, attributedString: &attributedString)
        makeBulletAttributes(word: .Onboarding.secondStepTimer, text: text, attributedString: &attributedString)
        
        return attributedString
    }
    
    func makeTextAttributes(location: Int, length: Int, attributedString: inout NSMutableAttributedString) {
        let otherTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.appRegularFont(13.0),
            .foregroundColor: UIColor.appText,
            
        ]
        
        attributedString.addAttributes(otherTextAttributes, range: NSRange(location: location, length: length))
        
    }
    
    func makeBulletAttributes(word serchwd: String, text: String, attributedString: inout NSMutableAttributedString){
        let bulletAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.appBoldFont(13.0),
            .foregroundColor: UIColor.appText,
            .paragraphStyle: NSMutableParagraphStyle().appendingNewline()
            
        ]

        var i = 0
        var word = ""
        for simb in text {
            if simb ==  " " {
                if word == " " + serchwd {
                    attributedString.addAttributes(bulletAttributes, range: NSRange(location: i-word.count, length: word.count))
                }
                word = ""
            }
            word += String(simb)
            i+=1
        }
    }
    
    
}

extension NSMutableParagraphStyle {
    func appendingNewline() -> NSMutableParagraphStyle {
        let copy = mutableCopy() as! NSMutableParagraphStyle
        copy.alignment = .left
        copy.headIndent = 10.0
        copy.firstLineHeadIndent = 0.0
        copy.tailIndent = 0.0
        return copy
    }
}

