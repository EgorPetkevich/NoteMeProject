//
//  NotificationDataWorker.swift
//  NoteMe
//
//  Created by George Popkich on 23.04.24.
//

import Foundation
import Storage
import CoreData
import CoreLocation

protocol NotificationServiceDataWorkerUseCase {
    func makeNotifications(from dtos: [any DTODescription])
    func removeNotifications(ids: [String])
}

final class NotificationDataWorker {
    
    typealias ComplitionHandler = (Bool) -> Void
    
    private let backupService: FireBaseBackupService
    private var storage: AllNotificationStorage
    private let notificationService: NotificationServiceDataWorkerUseCase
    
    init(storage: AllNotificationStorage,
         backupService: FireBaseBackupService,
         notificationService: NotificationServiceDataWorkerUseCase) {
        self.storage = storage
        self.backupService = backupService
        self.notificationService = notificationService
    }
    
    func updateOrCreate(dto: any DTODescription,
                        complition: ComplitionHandler? = nil) {
        storage.updateOrCreate(dto: dto) { [weak self] isSuccess in
                defer{ complition?(isSuccess) }
            
                guard isSuccess else { return }
            
                self?.notificationService.makeNotifications(from: [dto])
                self?.backupService.backup(dto: dto)
        }
    }
    
    func deleteByUser(dto: any DTODescription,
                complition: ComplitionHandler? = nil) {
        storage.delete(dto: dto) { [notificationService,
                                 backupService] isSuccess in
            defer{ complition?(isSuccess) }
            
            guard isSuccess else { return }
            
            notificationService.removeNotifications(ids: [dto.id])
            backupService.delete(id: dto.id)
        }
    }
    
    func deleteByLogout(complition: ComplitionHandler? = nil) {
        let allDTOs = storage.fetch()
        let allIds = allDTOs.map { $0.id }
        
        notificationService.removeNotifications(ids: allIds)
        storage.deleteAll(dtos: allDTOs, complition: complition)
    }
    
    func restore(complition: ComplitionHandler? = nil) {
        backupService.loadBackup { [weak self] dtos in
            self?.storage.createDTOs(dtos: dtos) {  isSuccess in
                defer { complition?(isSuccess) }
                
                self?.notificationService.makeNotifications(from: dtos)
            }
        }
    }
    
}
