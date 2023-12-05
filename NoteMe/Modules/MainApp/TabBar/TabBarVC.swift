//
//  TapBarVC.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

protocol TabBarViewModelProtocol {
    func homeButtonDidTap()
    func profileButtonDidTap()
}

final class TabBarVC: UIViewController {
    
    private var viewModel: TabBarViewModelProtocol
    
    init(viewModel: TabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}
