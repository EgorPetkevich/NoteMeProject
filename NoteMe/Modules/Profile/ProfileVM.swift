//
//  ProfileVM.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func openMap()
    func finish()
}

protocol ProfileAuthServiceUseCaseProtocol {
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
    func getUserEmail() -> String?
}

protocol ProfileAdapterProtocol {
    var selectMap: (() -> Void)? { get set }
    var selectNotifications: (()-> Void)? { get set }
    var selectExport: (() -> Void)? { get set }
    var selectLogout: (() -> Void)? { get set }
    
    func reloadData()
    func reloadData(whith sections: [ProfileSections])
    func makeTableView() -> UITableView
}

protocol ProfileAlertServiceUseCase {
    func showAlert(title: String,
                   message: String,
                   okTitile: String)
    func showAlert(title: String?,
                   message: String?,
                   cancelTitle: String?,
                   okTitle: String?,
                   okHandler: (() -> Void)?)

}

final class ProfileVM: ProfileViewModelProtocol {
    
    private weak var coordinator: ProfileCoordinatorProtocol?
    private var userName: String = "user_email@gmai.com"
    private let alertService: ProfileAlertServiceUseCase
    private let authService: ProfileAuthServiceUseCaseProtocol
    private var adapter: ProfileAdapterProtocol
    
    var sections: [ProfileSections] {
        return [
            .account(getUserEmail()),
            .map,
            .settings(ProfileSettingsRows.allCases)
        ]
    }
    
    init(coordinator: ProfileCoordinatorProtocol? = nil, 
         authService: ProfileAuthServiceUseCaseProtocol,
         adapter: ProfileAdapterProtocol,
         alertService: ProfileAlertServiceUseCase) {
        self.coordinator = coordinator
        self.authService = authService
        self.adapter = adapter
        self.alertService = alertService
        
        commonInit()
        bind()
    }
    
    private func bind() {
        adapter.selectMap = { [weak self]  in
            self?.coordinator?.openMap()
        }
        adapter.selectLogout = { [weak self]  in
            self?.logout()
        }
    }
    
    func makeTableView() -> UITableView {
        return adapter.makeTableView()
    }
    
    private func commonInit() {
        adapter.reloadData(whith: sections)
    }
    
    private func getUserEmail() -> String {
        userName = authService.getUserEmail() ?? "user_email@gmai.com"
        return userName
    }
    
    func logout() {
            alertService.showAlert(title: "Logout",
                                   message: "Are you want to logout? \n\(userName)",
                                   cancelTitle: "cancel",
                                   okTitle: "logout",
                                   okHandler: { [weak self] in
                self?.didSelectLogout()
            })
        }
        
        private func didSelectLogout() {
            authService.logout { [weak self] result in
                switch result {
                case .success(_):
                    ParametersHelper.set(.authenticatied, value: false)
                    self?.coordinator?.finish()
                case .failure(let error):
                    self?.alertService.showAlert(title: "Error",
                                                 message: error.localizedDescription,
                                                 okTitile: "ok")
                }
            }
        }
    
}
