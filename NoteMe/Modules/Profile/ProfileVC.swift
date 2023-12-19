//
//  ProfileVC.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

final class ProfileVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .appContentWhite
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: "Profile",
                                       image: .TabBar.selectedProfile,
                                       tag: .zero)
    }
    
}
