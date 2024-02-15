//
//  DateNotificationVM.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit
import Storage

protocol DateNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol KeyboardHelperDateNotificationUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private let keyboardHelper: KeyboardHelperDateNotificationUseCaseProtocol
    private let service: NotificationStorage<DateNotificationDTO>
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperDateNotificationUseCaseProtocol,
         coordinator: DateNotificationCoordinatorProtocol, 
         service: NotificationStorage<DateNotificationDTO>) {
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.service = service
        
        bind()
    }
    
    private func bind() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }
    }
    
    func createDidTap(title: String?, date: String?, comment: String?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        
        guard
            let title, let date = dateFormatter.date(from: date ?? "")
        else { return }
        
        let dto = DateNotificationDTO(date: date,
                                      id: UUID().uuidString,
                                      title: title,
                                      subtitle: comment,
                                      completedDate: nil,
                                      targetDate: date)

        service.create(dto: dto) { [weak self] complition in
            print(complition)
            self?.coordinator?.finish()
        }
        
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    
}