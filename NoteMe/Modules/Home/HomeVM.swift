//
//  HomeVM.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//

import UIKit
import Storage

protocol HomeAdapterProtocol: AnyObject {
    func reloadDate(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
    var tapButtonOnDTO: ((_ sender: UIButton,
                          _ dto: any DTODescription) -> Void)? { get set}
}

protocol HomeCoordinatorProtocol: AnyObject {
    func startEdite(date dto: any DTODescription)
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
    
}

final class HomeVM: HomeViewModelProtocol {
    
    private weak var coordinator: HomeCoordinatorProtocol?
    
    private let frcService: FRCService<BaseNotificationDTO>
    private let adapter: HomeAdapterProtocol
    private let storage: AllNotificationStorage
    var showPopup: ((_ sender: UIButton) -> Void)?
    private var selectedDTO: (any DTODescription)?
    
    init(adapter: HomeAdapterProtocol,
         storage: AllNotificationStorage,
         coordinator: HomeCoordinatorProtocol,
         frcService: FRCService<BaseNotificationDTO> ) {
        self.adapter = adapter
           self.storage = storage
           self.coordinator = coordinator
           self.frcService = frcService
        
           bind()
       }
    
    private func bind() {
        frcService.didChangeContent = { [weak adapter] dtoList in
            adapter?.reloadDate(dtoList)
        }
        
        adapter.tapButtonOnDTO = { [weak self] sender, dto in
            guard let self else { return }
            self.selectedDTO = dto
            self.coordinator?.showMenu(sender: sender, delegate: self)
        }
    }
    
    func viewDidLoad() {
        frcService.startHandle()
        let dtos = frcService.fetchedDTOs
        adapter.reloadDate(dtos)
    }
    
    func makeTableView() -> UITableView {
        return adapter.makeTableView()
    }
    
}

extension HomeVM: MenuPopoverDelegate {
    
    func didSelect(action: MenuPopoverVC.Action) {
        guard let dto = selectedDTO else { return }
        switch action {
        case .edit:
            coordinator?.startEdite(date: dto)
        case .delete:
            storage.delete(dto: dto)
        default: break
        }
    }
    
}
