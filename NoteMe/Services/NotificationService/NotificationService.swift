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
    
    func makeLocationNotification(notifyOnEntry: Bool = true,
                                  notifyOnExit: Bool = false,
                                  repeats: Bool = false,
                                  dto: LocationNotificationDTO) {
        guard let circleRegion = creatCircularRegion(with: dto) else { return }
        
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
    
    func updateOrCreateNotification(dto: any DTODescription) {
        removeNotification(id: dto.id)
        
        switch dto {
        case is DateNotificationDTO:
            guard let dto = dto as? DateNotificationDTO else { return }
            makeDateNotification(dto: dto)
        case is TimerNotificationDTO:
            guard let dto = dto as? TimerNotificationDTO else { return }
            makeTimerNotification(dto: dto)
        case is LocationNotificationDTO:
            guard let dto = dto as? LocationNotificationDTO else { return }
            makeLocationNotification(dto: dto)
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
    
    private func creatCircularRegion(
        with dto: LocationNotificationDTO
    ) -> CLCircularRegion? {
   
        let distanceRadius = CLLocationDistance(dto.radius)
        let mapRegion =  CLLocationCoordinate2D(latitude: dto.latitude,
                                                longitude:  dto.longitude)
        let circleRegion = CLCircularRegion(center: mapRegion,
                                            radius: distanceRadius,
                                            identifier: dto.id)
        return circleRegion
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
