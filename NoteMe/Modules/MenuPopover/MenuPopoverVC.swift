//
//  MenuPopoverVC.swift
//  NoteMe
//
//  Created by George Popkich on 27.02.24.
//

import UIKit

protocol MenuPopoverAdapterProtocol {
    var tableView: UITableView { get }
    var contentHeight: CGFloat { get }
    var didSelectAction: ((MenuPopoverVC.Action) -> Void)? { get set }
}

protocol MenuPopoverDelegate: AnyObject {
    func didSelect(action: MenuPopoverVC.Action)
}

final class MenuPopoverVC: UIViewController {
    
    private enum Const {
        static let contentWidth: CGFloat = 180.0
    }
    
    enum Action: MenuActionItem {
        case edit
        case delete
        case calendar
        case timer
        case location
        
        var title: String {
            switch self {
            case .edit: return "Edit"
            case .delete: return "Delete"
            case .calendar: return "Calendar"
            case .timer: return "Timer"
            case .location: return "Location"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .edit: return .PopNotifications.edit
            case .delete: return .PopNotifications.delete
            case .calendar: return .PopNotifications.calendar
            case .timer: return .PopNotifications.timer
            case .location: return .PopNotifications.location
            }
        }
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .popover } set {}
    }
    
    private var adapter: MenuPopoverAdapterProtocol
    
    private lazy var tableView: UITableView = adapter.tableView
    
    private weak var delegate: MenuPopoverDelegate?
    
    init(delegate: MenuPopoverDelegate?,
         adapter: MenuPopoverAdapterProtocol,
         sourseView: UIView) {
        self.delegate = delegate
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
        
        setupPopover(sourseView: sourseView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupUI()
        setupConstrains()
    }
    
    private func bind() {
        adapter.didSelectAction = { [weak self] action in
            self?.delegate?.didSelect(action: action)
            self?.dismiss(animated: true, completion: {
                self?.delegate?.didSelect(action: action)
            })
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func setupConstrains() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(
                self.view.safeAreaLayoutGuide.snp.verticalEdges)
//            make.height.equalTo(adapter.contentHeight)
        }
    }
    
    private func setupPopover(sourseView: UIView) {
        preferredContentSize = CGSize(width: Const.contentWidth,
                                      height: adapter.contentHeight)
        popoverPresentationController?.sourceView = sourseView
        popoverPresentationController?.delegate = self
        popoverPresentationController?.sourceRect = CGRect(x: sourseView.bounds.midX,
                                                              y: sourseView.bounds.midY,
                                                              width: .zero,
                                                              height: .zero)
    }
    
}

extension MenuPopoverVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        return .none
    }
    
}
