//
//  NotificationHandler.swift
//  NoteMe
//
//  Created by George Popkich on 2.04.24.
//

import Foundation
import Storage
import UserNotifications

final class NotificationHandler {
    
    private let storage: AllNotificationStorage = .init()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func chekIsCompleted() {
        notificationCenter.getDeliveredNotifications { 
            [weak self] notifications in
            self?.setIsCompleted(notifications: notifications)
        }
    }
    
    func setIsComplited(notification: UNNotification) {
        let id = notification.request.identifier
        let date = notification.date
        
        var dto = storage
            .fetch(predicate: .Notification.noutification(byId: id))
            .first
        
        dto?.completedDate = date
        
        guard let dto else { return }
        storage.update(dto: dto)
        
    }
    
    private func setIsCompleted(notifications: [UNNotification]) {
        let ids = notifications.map { $0.request.identifier }
        
        let dtos = storage
            .fetch(predicate: .Notification.notifications(in: ids))
            .map { dto in
                var updatedDTO = dto
                let date = notifications.first { 
                    $0.request.identifier  == dto.id }?
                    .date
                updatedDTO.completedDate = date
                return updatedDTO
            }
        storage.udateDTOs(dtos: dtos)
    }
    
}
