//
//  HomeVM.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//
import UIKit
import Storage

protocol HomeAdapterProtocol: AnyObject {
    var tapButtonOnDTO: ((_ sender: UIButton,
                          _ dto: any DTODescription) -> Void)? { get set}
    var filterDidSelect: ((NotificationFilterType) -> Void)? { get set }
    
    func reloadDate(_ dtoList: [any DTODescription])
    func makeTableView() -> UITableView
}

protocol HomeCoordinatorProtocol: AnyObject {
    func startEdite(date dto: any DTODescription)
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate)
}

protocol HomeFRCServiceUseCaseProtocol {
    var fetchedDTOs: [any DTODescription] { get }
    var didChangeContent: (([any DTODescription]) -> Void)? { get set }
    func startHandle()
}

protocol HomeNotificationDataWorkerUseCaseProtocol {
    func deleteByUser(dto: any DTODescription)
}

final class HomeVM: HomeViewModelProtocol {
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private var selectedFilter: NotificationFilterType = .all {
        didSet {
            adapter.reloadDate(filterResults())
        }
    }
    
    private let adapter: HomeAdapterProtocol
    private var frcService: HomeFRCServiceUseCaseProtocol
    private var dataWorker: HomeNotificationDataWorkerUseCaseProtocol
    var showPopup: ((_ sender: UIButton) -> Void)?
    private var selectedDTO: (any DTODescription)?
    
    init(adapter: HomeAdapterProtocol,
         coordinator: HomeCoordinatorProtocol,
         frcService: HomeFRCServiceUseCaseProtocol,
         dataWorker: HomeNotificationDataWorkerUseCaseProtocol ) {
        self.adapter = adapter
        self.coordinator = coordinator
        self.frcService = frcService
        self.dataWorker = dataWorker
        
        bind()
       }
    
    private func bind() {
        frcService.didChangeContent = { [weak self] dtoList in
            self?.adapter.reloadDate(self?.filterResults() ?? [])
        }
        
        adapter.tapButtonOnDTO = { [weak self] sender, dto in
            guard let self else { return }
            self.selectedDTO = dto
            self.coordinator?.showMenu(sender: sender, delegate: self)
        }
        
        adapter.filterDidSelect = { [weak self] type in
            self?.selectedFilter = type
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
    
    private func filterResults() -> [any DTODescription] {
        return  frcService.fetchedDTOs.filter { dto in
            switch selectedFilter {
            case .date:
                return  dto is DateNotificationDTO
            case .timer:
                return dto is TimerNotificationDTO
            case .location:
                return dto is LocationNotificationDTO
            default:
                return true
            }
        }
    }
    
}

extension HomeVM: MenuPopoverDelegate {
    
    func didSelect(action: MenuPopoverVC.Action) {
        guard let dto = selectedDTO else { return }
        switch action {
        case .edit:
            coordinator?.startEdite(date: dto)
        case .delete:
            dataWorker.deleteByUser(dto: dto)
        default: break
        }
    }
    
}
