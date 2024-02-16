//
//  TimeNotificationVM.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

protocol TimeNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol KeyboardHelperTimeNotificationUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol TimeNotificationStorageUseCaseProtocol {
    func create(dto: TimeNotificationDTO, complition: @escaping (Bool) -> Void)
}

final class TimeNotificationVM: TimeNotificationViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private let keyboardHelper: KeyboardHelperTimeNotificationUseCaseProtocol
    private let service: TimeNotificationStorageUseCaseProtocol
    
    private weak var coordinator: TimeNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperTimeNotificationUseCaseProtocol,
         coordinator: TimeNotificationCoordinatorProtocol,
         service: TimeNotificationStorageUseCaseProtocol) {
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
    
    func createDidTap(title: String?, time: String?, comment: String?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm.cc"
        
        guard
            let title, let time = dateFormatter.date(from: time ?? "")
        else { return }
        
        let dto = TimeNotificationDTO(date: Date.now,
                                      id: UUID().uuidString,
                                      title: title,
                                      time: time)
        
        service.create(dto: dto) { [weak self] complition in
            print(complition)
            self?.coordinator?.finish()
        }
        
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    
}
