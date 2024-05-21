//
//  DataWorker+Date.swift
//  NoteMe
//
//  Created by George Popkich on 21.05.24.
//

import Foundation
import Foundation
import Storage

struct DateDataWorker: DateNotificationDataWorkerUseCaseProtocol {
    
    private var dataWorker: NotificationDataWorker
    
    init(dataWorker: NotificationDataWorker) {
        self.dataWorker = dataWorker
    }
    
    func updateOrCreate(dto: DateNotificationDTO) {
        dataWorker.updateOrCreate(dto: dto) { complition in
            print(#function + "\(complition)")
        }
    }
    
}
