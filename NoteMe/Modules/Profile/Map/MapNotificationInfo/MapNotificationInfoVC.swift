//
//  MapNotificationInfoVC.swift
//  NoteMe
//
//  Created by George Popkich on 22.04.24.
//

import UIKit
import SnapKit

protocol MapNotificationInfoViewModelProtocol {
    var title: String? { get }
    var subtitle: String? { get }
}

final class MapNotificationInfoVC: UIViewController {
    
    private lazy var pinchView = UIView()
    private lazy var titleLabel: UILabel = .bold("Title:", 20.0, .appText)
    private lazy var subtitleLabel: UILabel = .bold("Subtitle:", 20.0, .appText)
    private lazy var notificationTitle: UILabel =
        .regular(viewModel.title ?? "", 16.0)
    private lazy var notificationSubtitle: UILabel =
        .regular(viewModel.subtitle ?? "", 16.0)
    
    private var viewModel: MapNotificationInfoViewModelProtocol
    
    init(viewModel: MapNotificationInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupIU()
        setupConstrains()
    }
    
    private func setupIU() {
        view.backgroundColor = .appInfoWhite
        pinchView.backgroundColor = .appSeparator
        pinchView.cornerRadius = 5.0
        
        view.addSubview(pinchView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(notificationTitle)
        view.addSubview(notificationSubtitle)
    }
    
    private func setupConstrains() {
        pinchView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5.0)
            make.width.equalTo(48.0)
            make.height.equalTo(8.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().inset(20)
        }
        
        notificationTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.left.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationTitle.snp.bottom).offset(20.0)
            make.left.equalToSuperview().inset(20)
        }
        
        notificationSubtitle.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20.0)
            make.left.equalToSuperview().inset(20)
        }
    }
    
}

