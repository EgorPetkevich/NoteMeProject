//
//  DataWorker+Timer.swift
//  NoteMe
//
//  Created by George Popkich on 21.05.24.
//

import Foundation
import Storage

struct TimerDataWorker: TimerNotificationDataWorkerUseCaseProtocol  {
    
    private var dataWorker: NotificationDataWorker
    
    init(dataWorker: NotificationDataWorker) {
        self.dataWorker = dataWorker
    }
    
    func updateOrCreate(dto: TimerNotificationDTO) {
        dataWorker.updateOrCreate(dto: dto) { complition in
            print(#function + "TimerNotification \(complition)")
        }
    }
    
}

