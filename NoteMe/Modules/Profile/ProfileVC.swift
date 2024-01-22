//
//  ProfileVC.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

protocol ProfileViewModelProtocol {
    var userEmail: ((String?) -> Void)? { get set }
    func notiButtonDidTap()
    func exportButtonDidTap()
    func logoutButtonDidTap()
}

final class ProfileVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var accountView: UIView = .info()
    private lazy var settingView: UIView = .info()
    
    private lazy var accountLabel: UILabel = .bold("Account", 14.0, .appText)
    private lazy var settingsLabel: UILabel = .bold("Settings", 14.0, .appText)
    
    private lazy var youEmailLabel: UILabel = .regular("Your e-mail:", 17.0, .appGrayText)
    
    private var userEmailLabel: UILabel = .regular("userEmail@gmail.com", 17.0, .appText)
    
    private lazy var notificationsLabel: UILabel = .regular("Notifications", 14.0, .appText)
    
    
    private lazy var notificationsButton: LineButton = LineButton()
        .setButtonTitle("Notificactions")
        .setButtonImage(.Profile.notifiaction)
        .setTarger(targer: self, selector: #selector(notiButtonDidTap))
    
   
    private lazy var exportButton: LineButton = LineButton()
        .setButtonTitle("Export")
        .setButtonImage(.Profile.export)
        .setTarger(targer: self, selector: #selector(exportButtonDidTap))

    private lazy var logoutButton: LineButton = LineButton()
        .setButtonTitle("Logout")
        .setButtonImage(.Profile.logout)
        .setTarger(targer: self, selector: #selector(logoutDidTap))
        .setTextColor(.appRed)
        .setSeparator(true)
    
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupTabBarItem()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstrains()
        bind()
    }
    
    private func bind() {
        viewModel.userEmail = { [weak self] userEmail in
            self?.userEmailLabel.text = userEmail ?? ""
        }
    }
    
    private func setup() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        
        contentView.addSubview(settingView)
        contentView.addSubview(accountView)
        contentView.addSubview(accountLabel)
        contentView.addSubview(settingsLabel)
        
        accountView.addSubview(youEmailLabel)
        accountView.addSubview(userEmailLabel)
        
        settingView.addSubview(notificationsButton)
        settingView.addSubview(exportButton)
        settingView.addSubview(logoutButton)
        
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: "Profile",
                                       image: .TabBar.selectedProfile,
                                       tag: .zero)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().inset(-30.0)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.height.equalTo(16.0)
            make.top.left.equalToSuperview().inset(20.0)
        }
        
        accountView.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(73.0)
        }
        
        youEmailLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16.0)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(youEmailLabel.snp.bottom).inset(-4.0)
            make.left.equalToSuperview().inset(16.0)
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(accountView.snp.bottom).inset(-16.0)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(16.0)
        }
        
        settingView.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).inset(-16.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
        }
        
        notificationsButton.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
            make.height.equalTo(30.0)
        }
        
        exportButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(notificationsButton.snp.bottom).inset(-16)
            make.height.equalTo(30.0)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(exportButton.snp.bottom).inset(-16)
            make.height.equalTo(30.0)
            make.bottom.equalToSuperview().inset(16.0 - 13.0)
        }
    }
    
    @objc func notiButtonDidTap() {
        viewModel.notiButtonDidTap()
    }
    @objc func exportButtonDidTap() {
        viewModel.exportButtonDidTap()
    }
    
    @objc func logoutDidTap() {
        viewModel.logoutButtonDidTap()
    }
    
}
