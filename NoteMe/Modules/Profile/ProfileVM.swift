//
//  ProfileVM.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ProfileAuthServiceUseCaseProtocol {
    func logout(completion: @escaping (Bool) -> Void)
    func getUserEmail() -> String?
}

protocol ProfileAdapterProtocol {
    func reloadData(whith sections: [ProfileSections])
    func makeTableView() -> UITableView
}

final class ProfileVM: ProfileViewModelProtocol {
    
    private weak var coordinator: ProfileCoordinatorProtocol?
    
    private let authService: ProfileAuthServiceUseCaseProtocol
    private let adapter: ProfileAdapterProtocol
    
    var sections: [ProfileSections] {
        return [
            .account(authService.getUserEmail() ?? ""),
            .settings(ProfileSettingsRows.allCases)
        ]
    }
    
    init(coordinator: ProfileCoordinatorProtocol? = nil, 
         authService: ProfileAuthServiceUseCaseProtocol,
         adapter: ProfileAdapterProtocol) {
        self.coordinator = coordinator
        self.authService = authService
        self.adapter = adapter
        
        commonInit()
    }
    
    func makeTableView() -> UITableView {
        return adapter.makeTableView()
    }
    
    private func commonInit() {
        adapter.reloadData(whith: sections)
    }
    
}
