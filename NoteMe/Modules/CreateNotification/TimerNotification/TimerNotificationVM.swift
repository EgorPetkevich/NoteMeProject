//
//  TimeNotificationVM.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage

protocol TimerNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol KeyboardHelperTimerNotificationUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol TimerNotificationStorageUseCaseProtocol {
    func create(dto: TimerNotificationDTO, 
                complition: @escaping (Bool) -> Void)
    func  updateOrCreate(dto: Storage.TimerNotificationDTO,
                         complition: @escaping (Bool) -> Void)
}

protocol TimerNotificationServiceUseCaseProtocol {
    func updateOrCreate(dto: TimerNotificationDTO)
}


final class TimerNotificationVM: TimerNotificationViewModelProtocol {
    
    typealias TimerSet = (title: String, targetDate: Date, comment: String)
    
    var editTitle: String?
    var editTimer: String?
    var editComment: String?
    
    var catchTitleError: ((String?) -> Void)?
    var catchTimerError: ((String?) -> Void)?
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private var dto: TimerNotificationDTO?
    
    private let keyboardHelper: KeyboardHelperTimerNotificationUseCaseProtocol
    private let storage: TimerNotificationStorageUseCaseProtocol
    private let notificationService: TimerNotificationServiceUseCaseProtocol
    
    private weak var coordinator: TimerNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperTimerNotificationUseCaseProtocol,
         coordinator: TimerNotificationCoordinatorProtocol,
         storage: TimerNotificationStorageUseCaseProtocol,
         notificationService: TimerNotificationServiceUseCaseProtocol,
         dto: TimerNotificationDTO? = nil) {
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.storage = storage
        self.notificationService = notificationService
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
        editTimer = timeFormatter(dto.timeLeft)
        editComment = dto.subtitle
    }
    
    func createDidTap(title: String?, time: String?, comment: String?) {
        guard
            let timerSet = checkValid(title: title,
                                     time: time,
                                      comment: comment)
       
        else { return }
        
        
        let newDTO = TimerNotificationDTO(date: Date(),
                                          title: timerSet.title,
                                          subtitle: timerSet.comment,
                                          targetDate: timerSet.targetDate)
        
        dto?.title = timerSet.title
        dto?.subtitle = timerSet.comment
        dto?.targetDate =  timerSet.targetDate
        
        notificationService.updateOrCreate(dto: dto ?? newDTO)
        
        storage.updateOrCreate(dto: dto ?? newDTO) { complition in
            print(#function, "comlition Timer Notificatoin: \(complition)")
        }
        self.coordinator?.finish()
        
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func timeFormatter(_ timeLeft: Double?) -> String? {
        guard let timeLeft else { return nil}
        if timeLeft >= 0 {
            let time = NSInteger(timeLeft)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)
            return String(format: "%0.2d.%0.2d",
                                     hours,
                                     minutes)
        } else {
            return "00.00"
        }
    }
    
    private func checkValid(title: String?,
                            time: String?,
                            comment: String?) -> TimerSet? {
        var dateSet: TimerSet
        guard
            let title,
            title != "",
            title != "Enter Title",
            let time = Double(time ?? ""),
            let comment
        else {
            errorValidation()
            return nil
        }
        
        dateSet.title = title
        dateSet.targetDate = Date().addingTimeInterval(TimeInterval(NSInteger(time) * 60 * 60 + NSInteger(time * 100) % 100 * 60))
        dateSet.comment = comment
        
        if comment == "Enter Comment" {
            dateSet.comment = ""
        }

        return dateSet
        
    }
    
    private func errorValidation(isTitleValid: Bool = false,
                                 isDateValid: Bool = false) {
        catchTitleError?(isTitleValid ? nil : "Enter Title")
        catchTimerError?(isDateValid ? nil : "Enter Time")
    }
    
}
