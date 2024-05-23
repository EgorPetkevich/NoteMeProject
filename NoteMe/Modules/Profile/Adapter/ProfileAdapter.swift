//
//  ProfileAdapter.swift
//  NoteMe
//
//  Created by George Popkich on 30.01.24.
//

import UIKit

final class ProfileAdapter: NSObject {
    
    var selectMap: (() -> Void)?
    var selectNotifications: (()-> Void)?
    var selectExport: (() -> Void)?
    var selectLogout: (() -> Void)?
    
    var sections: [ProfileSections] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.setShadow()
        return tableView
    }()
    
    override init() {
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileSettingsCell.self)
        tableView.register(ProfileMapCell.self)
        tableView.register(ProfileAccountCell.self)
    }
    
}

extension ProfileAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("\(sections.count)")
        return sections.count
       
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .account(let email):
            let cell: ProfileAccountCell = tableView.dequeue(at: indexPath)
            cell.setup(email)
            return cell
        case .map:
            let cell: ProfileMapCell = tableView.dequeue(at: indexPath)
            return cell
        case .settings(let rows):
            let cell: ProfileSettingsCell = tableView.dequeue(at: indexPath)
            cell.setup(rows[indexPath.row])
            return cell
        }
    }

}

extension ProfileAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        let header = ProfileTableViewHeader()
        header.text = section.headerText
        return header
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        switch section {
        case .map: selectMap?()
        case .settings(let rows): didSelectSetting(with: rows[indexPath.row])
        default : break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didSelectSetting(with row: ProfileSettingsRows) {
        switch row {
        case .notifications: selectNotifications?()
        case .export: selectExport?()
        case .logout: selectLogout?()
        }
    }
    
}

extension ProfileAdapter: ProfileAdapterProtocol {
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func reloadData(whith sections: [ProfileSections]) {
        self.sections = sections
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
    
    
}
