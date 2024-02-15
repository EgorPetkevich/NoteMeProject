//
//  PopNotificationSelectorVM.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//

import UIKit

protocol PopNotificationSelectorCoordinatorProtocol: AnyObject {
    func openCalendar()
}

protocol PopNotificationAdapterProtocol {
    var didSelectNotificationRow: ((NotificationsRows) -> Void)? { get set }
    var didSelectEditRow: ((EditNotificationRows) -> Void)? { get set }
    
    func reloadData(whith sections: [PopSelectionSections])
    func makeTableView() -> UITableView
}

enum PopNotificationSections {
    case notifications
    case edit
}

final class PopNotificationSelectorVM: PopNotificationSelectorViewModelProtocol {
    
    private var adapter: PopNotificationAdapterProtocol
    private let popNotificatoinSection: PopNotificationSections
    
    private var coordinator: PopNotificationSelectorCoordinatorProtocol?
    
    var section: [PopSelectionSections] {
        switch popNotificatoinSection {
        case .notifications:
            notificationrowSelected()
            return [.add(NotificationsRows.allCases)]
        case .edit:
            editNotificationrowSelected()
            return [.edit(EditNotificationRows.allCases)]
        }
    }
    
    init(adapter: PopNotificationAdapterProtocol, 
         select: PopNotificationSections,
         coordinator: PopNotificationSelectorCoordinatorProtocol) {
        self.adapter = adapter
        self.popNotificatoinSection = select
        self.coordinator = coordinator
        commonInit()
    }
    
    private func notificationrowSelected() {
        adapter.didSelectNotificationRow = { [weak self] row in
            switch row {
            case .calendar:
                self?.coordinator?.openCalendar()
            case .location:
                print("location")
            case .timer:
                print("timer")
            }
        }
    }
    
    private func editNotificationrowSelected() {
        adapter.didSelectEditRow = { row in
            switch row {
            case .edit:
                print("edit")
            case .delete:
                print("delete")
            }
        }
    }
        
    func makeTableView() -> UITableView {
        return adapter.makeTableView()
    }
    
    private func commonInit() {
        adapter.reloadData(whith: section)
    }
    
}
