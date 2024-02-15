//
//  PopNotificationSelectorVC.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//

import UIKit
import SnapKit

protocol PopNotificationSelectorViewModelProtocol {
    func makeTableView() -> UITableView
}

final class PopNotificationSelectorVC: UIViewController {
    
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private var viewModel: PopNotificationSelectorViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstrains()
    }
    
    init(viewModel: PopNotificationSelectorViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppend() {
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = .appContentWhite
        self.view.addSubview(tableView)
    }
    
    private func setupConstrains() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
}

extension PopNotificationSelectorVC: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        return .none
    }
    
}

