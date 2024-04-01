//
//  SearchLocationAdapter.swift
//  NoteMe
//
//  Created by George Popkich on 27.03.24.
//

import UIKit

final class SearchLocationAdapter: NSObject, SearchLocationAdapterProtocol {
    
    var selectSearchResualt: ((NearByResponseModel.Result) -> Void)?
    
    private var searchList: [NearByResponseModel.Result] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .appContentWhite
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.setShadow()
        return tableView
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchLocationCell.self,
                           forCellReuseIdentifier: "\(SearchLocationCell.self)")
    }
    
    func makeTableView() -> UITableView {
        tableView
    }
    
    func reloadDate(_ searchList: [NearByResponseModel.Result]) {
        self.searchList = searchList
    }
    
}

extension SearchLocationAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchRes = searchList[indexPath.row]
        
        let cell: SearchLocationCell = tableView.dequeue(at: indexPath)
        cell.setup(searchRes)
        
        return cell
    }
    
}

extension SearchLocationAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectSearchResualt?(searchList[indexPath.row])
    }
    
}

extension SearchLocationAdapter {
    
}
