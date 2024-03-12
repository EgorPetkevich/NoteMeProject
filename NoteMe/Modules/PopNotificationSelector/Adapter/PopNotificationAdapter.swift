//
//  PopNotificationAdapter.swift
//  NoteMe
//
//  Created by George Popkich on 15.02.24.
//

import UIKit

final class PopNotificationAdapter: NSObject {
    
    private enum Const {
        static let rowHeight: CGFloat = 40.0
    }
    
    enum Action {
        case edit
        case delet
        case calendar
        case location
        case timer
    }
    
    var didSelectNotificationRow: ((NotificationsRows) -> Void)?
    var didSelectEditRow: ((EditNotificationRows) -> Void)?
    var sections: [PopSelectionSections] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = Const.rowHeight
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
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
        tableView.register(PopSelectionCell.self,
                           forCellReuseIdentifier: "\(PopSelectionCell.self)")
    }
    
}

extension PopNotificationAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .edit(let rows):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "\(PopSelectionCell.self)",
                for: indexPath) as? PopSelectionCell
            cell?.setupEdit(rows[indexPath.row])
            return cell ?? UITableViewCell()
        case .add(let rows):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "\(PopSelectionCell.self)",
                for: indexPath) as? PopSelectionCell
            cell?.setupNotifications(rows[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }

}

extension PopNotificationAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let section = sections[indexPath.section]
        
        switch section {
        case .edit(let rows):
            let cell: EditNotificationRows = rows[indexPath.row]
            didSelectEditRow?(cell.hesh)
        case .add(let rows):
            let cell: NotificationsRows = rows[indexPath.row]
            didSelectNotificationRow?(cell.hesh)
        }
    }
    
}

extension PopNotificationAdapter: PopNotificationAdapterProtocol {
    
    func reloadData(whith sections: [PopSelectionSections]) {
        self.sections = sections
    }
    
    func makeTableView() -> UITableView {
        return tableView
    }
    
}
