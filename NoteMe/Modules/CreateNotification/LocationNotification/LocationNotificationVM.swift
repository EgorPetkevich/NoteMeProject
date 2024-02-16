//
//  LocationNotificationVM.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

protocol LocationNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol KeyboardHelperLocationNotificationUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol LocationNotificationStorageUseCaseProtocol {
    func create(dto: LocationNotificationDTO, complition: @escaping (Bool) -> Void)
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private let keyboardHelper: KeyboardHelperLocationNotificationUseCaseProtocol
    private let service: LocationNotificationStorageUseCaseProtocol
    
    private weak var coordinator: LocationNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperLocationNotificationUseCaseProtocol,
         coordinator: LocationNotificationCoordinatorProtocol,
         service: LocationNotificationStorageUseCaseProtocol) {
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.service = service
        
        bind()
    }
    
    private func bind() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }.onWillHide { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }
    }
    
    func createDidTap(title: String?, comment: String?) {
        
        guard let title else { return }
        let dto = LocationNotificationDTO(date: Date.now,
                                      id: UUID().uuidString,
                                      title: title)

        service.create(dto: dto) { [weak self] complition in
            print(complition)
            self?.coordinator?.finish()
        }
        
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    
}
