//
//  TapBarVC.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit
import SnapKit


@objc protocol MainTabBarViewModelProtocol {
    @objc func addButtonDidTap(sender: UIView)
}

final class MainTabBarVC: UITabBarController {
    
    private lazy var addButton: UIButton =
        .addHomeButton()
        .withAction(viewModel,
                    #selector(MainTabBarViewModelProtocol.addButtonDidTap))
    
    private var viewModel: MainTabBarViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstrains()
    }
    
    init(viewModel: MainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        tabBar.tintColor = .appYellow
        tabBar.backgroundColor = .appBackground
        tabBar.unselectedItemTintColor = .appInfoWhite
        
        view.addSubview(addButton)
        
    }
    
    private func setupConstrains() {
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.tabBar.snp.top)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        addButton.cornerRadius = 50 / 2
    }

    @objc private func addButtonDidTap() {
        viewModel.addButtonDidTap(sender: addButton)
    }
}


