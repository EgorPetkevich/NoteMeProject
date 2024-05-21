//
//  NotificationService.swift
//  NoteMe
//
//  Created by George Popkich on 3.04.24.
//

import Foundation
import UserNotifications
import CoreLocation
import Storage

final class NotificationService {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func makeDateNotification(dto: DateNotificationDTO) {
        let context = createContext(with: dto)
        let components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: dto.targetDate)
        let triger = UNCalendarNotificationTrigger(dateMatching: components,
                                                   repeats: false)
        let request = UNNotificationRequest(identifier: dto.id,
                                            content: context,
                                            trigger: triger)
        notificationCenter.add(request)
    }
    
    func makeTimerNotification(dto: TimerNotificationDTO) {
        let context = createContext(with: dto)
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: dto.timeLeft,
                                                       repeats: false)
        let request = UNNotificationRequest(identifier: dto.id,
                                            content: context,
                                            trigger: triger)
        notificationCenter.add(request)
    }
    
    func makeLocationNotification(circleRegion: CLCircularRegion,
                                  notifyOnEntry: Bool = true,
                                  notifyOnExit: Bool = false,
                                  repeats: Bool = false,
                                  dto: LocationNotificationDTO) {
        circleRegion.notifyOnEntry = notifyOnEntry
        circleRegion.notifyOnExit = notifyOnExit
        
        let triger = UNLocationNotificationTrigger(region: circleRegion,
                                                   repeats: false)
        let context = createContext(with: dto)
        let request = UNNotificationRequest(identifier: dto.id,
                                            content: context,
                                            trigger: triger)
        notificationCenter.add(request)
    }
    
    func updateOrCreateNotification(dto: any DTODescription,
                                    circleRegion: CLCircularRegion? = nil,
                                    notifyOnEntry: Bool? = nil,
                                    notifyOnExit: Bool? = nil,
                                    repeats: Bool? = nil) {
        removeNotification(id: dto.id)
        
        switch dto {
        case is DateNotificationDTO:
            guard let dto = dto as? DateNotificationDTO else { return }
            makeDateNotification(dto: dto)
        case is TimerNotificationDTO:
            guard let dto = dto as? TimerNotificationDTO else { return }
            makeTimerNotification(dto: dto)
        case is LocationNotificationDTO:
            guard
                let dto = dto as? LocationNotificationDTO,
                let notifyOnExit,
                let notifyOnEntry,
                let circleRegion
            else { return }
            makeLocationNotification(
                circleRegion: circleRegion, 
                notifyOnEntry: notifyOnEntry,
                notifyOnExit: notifyOnExit,
                dto: dto)
        default: break
        }
    }
    
    func removeNotification(id: String) {
        notificationCenter
            .removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    private func createContext(with dto: any DTODescription) ->
    UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = dto.title
        content.body = dto.subtitle ?? ""
        return content
    }
    
}


extension NotificationService:
    
    NotificationServiceDataWorkerUseCase {
    func makeNotifications(from dtos: [any DTODescription]) {
        dtos.forEach { dto in
            self.updateOrCreateNotification(dto: dto)
        }
    }
    
    func removeNotifications(ids: [String]) {
        ids.forEach { id in
            self.removeNotification(id: id)
        }
    }
    
}
