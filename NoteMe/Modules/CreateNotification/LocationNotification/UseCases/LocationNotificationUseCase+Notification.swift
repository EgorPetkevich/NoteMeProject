//
//  LocationNotificationUseCase+Notification.swift
//  NoteMe
//
//  Created by George Popkich on 7.04.24.
//

import Foundation
import CoreLocation
import Storage

struct LocationNotification: LocationNotificationServiceUseCaseProtocol {
 
    private var service: NotificationService
    
    init(service: NotificationService) {
        self.service = service
    }
    
    func updateOrCreate(dto: LocationNotificationDTO,
                                    circleRegion: CLCircularRegion?,
                                    notifyOnEntry: Bool,
                                    notifyOnExit: Bool,
                                    repeats: Bool) {
        service.updateOrCreateNotification(dto: dto,
                                           circleRegion: circleRegion,
                                           notifyOnEntry: notifyOnEntry,
                                           notifyOnExit: notifyOnExit,
                                           repeats: repeats)
    }
    
}
