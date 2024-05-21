//
//  NotificatoinDataWorker+Home.swift
//  NoteMe
//
//  Created by George Popkich on 21.05.24.
//

import Foundation
import Storage

struct HomeDataWorker: HomeNotificationDataWorkerUseCaseProtocol {
    
    private var dataWorker: NotificationDataWorker
    
    init(dataWorker: NotificationDataWorker) {
        self.dataWorker = dataWorker
    }
    
    func deleteByUser(dto: any DTODescription) {
        dataWorker.deleteByUser(dto: dto) { complition in
            print(#function + "\(complition)")
        }
    }
    
}
