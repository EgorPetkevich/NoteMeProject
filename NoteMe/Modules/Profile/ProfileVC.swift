//
//  ProfileVC.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

protocol ProfileViewModelProtocol {
    var sections: [ProfileSections] { get }
    
    func makeTableView() -> UITableView

}

final class ProfileVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
   
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstrains()

    }
    
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        
        contentView.addSubview(tableView)
        
    }
    
    private func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: "Profile",
                                       image: .TabBar.selectedProfile,
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

//
//extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
//    
//   
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        viewModel.buttons[indexPath.row].action()
//    }
//    
//    
//}
