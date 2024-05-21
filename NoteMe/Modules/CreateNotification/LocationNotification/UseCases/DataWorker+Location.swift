//
//  DataWorker+Location.swift
//  NoteMe
//
//  Created by George Popkich on 21.05.24.
//

import Foundation
import Foundation
import Storage

struct LocationDataWorker: LocationNotificationDataWorkerUseCaseProtocol {
    
    private var dataWorker: NotificationDataWorker
    
    init(dataWorker: NotificationDataWorker) {
        self.dataWorker = dataWorker
    }
    
    func updateOrCreate(dto: LocationNotificationDTO) {
        dataWorker.updateOrCreate(dto: dto) { complition in
            print(#function + "\(complition)")
        }
    }
    
}

