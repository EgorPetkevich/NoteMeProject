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
        
        
//        let request = PlaceSearchRequest(model: .init(query: "пицца", coordinates: .init(latitude: 53.867882, longitude: 27.609913)))
//        let session = NetworkSessionProvider()
//        session.send(request: request) { decode in
//            print(decode)
//        }
//        let service = LocationNetworkService()
//        service.getNearBy(coordinates: .init(latitude: 53.867882, longitude: 27.609913)) { array in
//            print(array.map { $0.name })
//        }
//        
//        service.getPlaceSearch(coordinates: .init(latitude: 53.867882, longitude: 27.609913), query: "пицца лисица") { array in
//            print(array.map { $0.name })
//        }
        
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
            make.horizontalEdges.verticalEdges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(10.0)
            make.bottom.equalToSuperview()
        }
    }
    
}
