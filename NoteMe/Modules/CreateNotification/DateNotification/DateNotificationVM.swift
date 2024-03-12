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
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol DateNotificationStorageUseCaseProtocol {
    func create(dto: DateNotificationDTO, complition: @escaping (Bool) -> Void)
    func updateOrCreate(dto: Storage.DateNotificationDTO,
                        complition: @escaping (Bool) -> Void)
}

final class DateNotificationVM: DateNotificationViewModelProtocol {
    
    typealias DateSet = (title: String, date: Date, comment: String)

    var editTitle: String?
    var editDate: Date?
    var editComment: String?
    
    var catchTitleError: ((String?) -> Void)?
    var catchDateError: ((String?) -> Void)?
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private var dto: DateNotificationDTO?
    
    private let keyboardHelper: KeyboardHelperDateNotificationUseCaseProtocol
    private let storage: DateNotificationStorageUseCaseProtocol
    
    private weak var coordinator: DateNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperDateNotificationUseCaseProtocol,
         coordinator: DateNotificationCoordinatorProtocol,
         storage: DateNotificationStorageUseCaseProtocol,
         dto: DateNotificationDTO? = nil) {
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.storage = storage
        self.dto = dto
        
        bindkeyboardHelper()
        bindEdit()
    }
    
    private func bindkeyboardHelper() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }.onWillHide { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }
    }
    
    private func bindEdit() {
        guard let dto else { return }
        editTitle = dto.title
        editDate = dto.targetDate
        editComment = dto.subtitle
    }
    
    func createDidTap(title: String?,
                      date: String?,
                      comment: String?) {
        guard
            let dateSet = checkValid(title: title,
                                     date: date,
                                     comment: comment)
        else { return }
        
        let newDTO = DateNotificationDTO(date: Date(),
                                         title: dateSet.title,
                                         subtitle: dateSet.comment,
                                         targetDate: dateSet.date)
        
        dto?.title = dateSet.title
        dto?.subtitle = dateSet.comment
        dto?.targetDate = dateSet.date
        storage.updateOrCreate(dto: dto ?? newDTO) { complition in
            print(#function, "comlition Date Notificatoin: \(complition)")
        }
        self.coordinator?.finish()
        
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func dateFormatter(date: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        
        if let date = dateFormatter.date(from: date ?? "") {
            return date
        }
    
        return nil
    }
    
    private func checkValid(title: String?,
                            date: String?,
                            comment: String?) -> DateSet? {
        var dateSet: DateSet
        guard
            let title,
            title != "",
            title != "Enter Title",
            let date = dateFormatter(date: date),
            let comment
        else {
            errorValidation()
            return nil
        }
        
        dateSet.title = title
        dateSet.date = date
        dateSet.comment = comment
        
        if comment == "Enter Comment" {
            dateSet.comment = ""
        }

        return dateSet
        
    }
    
    private func errorValidation(isTitleValid: Bool = false,
                                 isDateValid: Bool = false) {
        catchTitleError?(isTitleValid ? nil : "Enter Title")
        catchDateError?(isDateValid ? nil : "Enter Date")
    }
    
    
}
