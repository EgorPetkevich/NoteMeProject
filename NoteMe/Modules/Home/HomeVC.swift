//
//  HomeVC.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

protocol HomeViewModelProtocol {
    
}

import UIKit

final class HomeVC: UIViewController {
   
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
        self.tabBarItem = UITabBarItem(title: "Home",
                                       image: .TabBar.selectedHome,
                                      tag: .zero)
    }
    
}
