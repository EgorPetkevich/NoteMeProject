//
//  NotifcationsAdapter.swift
//  NoteMe
//
//  Created by George Popkich on 26.02.24.
//

import UIKit
import Storage
import CoreData
    
final class HomeAdapter: NSObject, HomeAdapterProtocol {
    
    private enum Const {
        static var headerHeight: CGFloat = 32.0 + 10
    }
    
//    private var selectedFilter
    
    var filterDidSelect: ((NotificationFilterType) -> Void)?

    var tapButtonOnDTO: ((_ sender: UIButton,
                          _ dto: any DTODescription) -> Void)?

    private var dtoList: [any DTODescription] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableHeaderView: NotificationFilterView = {
        let frame = CGRect(x: .zero, y: .zero, width: .zero, height: Const.headerHeight)
        let headerView = NotificationFilterView(frame: frame)
        headerView.delegate = self
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.addShadow()
        tableView.separatorStyle = .none
        tableView.cornerRadius = 5
        tableView.showsVerticalScrollIndicator = false
        tableView.setShadow()
        tableView.tableHeaderView = tableHeaderView
        return tableView
    }()
    
    override init() {
        super.init()
 
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DateCell.self)
        tableView.register(TimerCell.self)
        tableView.register(LocationCell.self)
    }
    
    func makeTableView() -> UITableView {
        tableView
    }
    
    
    func reloadDate(_ dtoList: [any DTODescription]) {
        self.dtoList = dtoList
    }
    
}

extension HomeAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dtoList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dto = dtoList[indexPath.row]
        
        switch dto {
        case is DateNotificationDTO:
            let cell: DateCell = tableView.dequeue(at: indexPath)
            cell.setup(dto as! DateNotificationDTO)
            cell.buttonDidTap = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
            
        case is TimerNotificationDTO:
            let cell: TimerCell = tableView.dequeue(at: indexPath)
            cell.setup(dto as! TimerNotificationDTO)
            cell.buttonDidTap = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
            
        case is LocationNotificationDTO:
            let cell: LocationCell = tableView.dequeue(at: indexPath)
            cell.setup(dto as! LocationNotificationDTO)
            cell.buttonDidTap = { [weak self] sender in
                self?.tapButtonOnDTO?(sender, dto)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

        
}

extension HomeAdapter: UITableViewDelegate {
    
}

extension HomeAdapter: NotificationFilterViewDelegate {
   
    func notificationFilterView(_ filterView: NotificationFilterView, 
                                didSelect type: NotificationFilterType) {
        filterDidSelect?(type)
    }
}

