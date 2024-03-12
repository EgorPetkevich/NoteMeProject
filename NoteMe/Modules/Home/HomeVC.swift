//
//  HomeVC.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

protocol HomeViewModelProtocol: AnyObject {
    func viewDidLoad()
    func makeTableView() -> UITableView
}

import UIKit


final class HomeVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var tableView: UITableView = viewModel.makeTableView()
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        setupUI()
        setupConstrains()
    }
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        
        contentView.addSubview(tableView)
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: "Home",
                                       image: .TabBar.selectedHome,
                                      tag: .zero)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16.0)
        }
    }
    
}
