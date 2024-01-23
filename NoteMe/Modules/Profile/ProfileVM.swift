//
//  ProfileVM.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import Foundation

protocol ProfileCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ProfileAuthServiceUseCaseProtocol {
    func logout(completion: @escaping (Bool) -> Void)
    func getUserEmail() -> String?
}

final class ProfileVM: ProfileViewModelProtocol {
    
    var userEmail: ((String?) -> Void)?
    
    private weak var coordinator: ProfileCoordinatorProtocol?
    
    private let authService: ProfileAuthServiceUseCaseProtocol
    
    init(coordinator: ProfileCoordinatorProtocol? = nil, 
         authService: ProfileAuthServiceUseCaseProtocol) {
        self.coordinator = coordinator
        self.authService = authService
        
        setUserEmail()
    }
    
    func setUserEmail() {
        userEmail?(authService.getUserEmail())
    }
    
    func notiButtonDidTap() {
        print("\(#function)")
    }
    
    func exportButtonDidTap() {
        print("\(#function)")
    }
    
    func logoutButtonDidTap() {
        print("\(#function)")
        authService.logout() { [weak self]
            isSuccess in
            print(isSuccess)
            if isSuccess {
                self?.coordinator?.finish()
            }
        }
    }
    
    
}
