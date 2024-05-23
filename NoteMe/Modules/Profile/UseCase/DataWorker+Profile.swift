//
//  DataWorker+Profile.swift
//  NoteMe
//
//  Created by George Popkich on 23.05.24.
//

import Foundation
import Storage

struct ProfileDataWorker: ProfileDataWorkerUseCaseProtocol  {
    
    private var dataWorker: NotificationDataWorker
    
    init(dataWorker: NotificationDataWorker) {
        self.dataWorker = dataWorker
    }
    
    func deleteByLogout(complition: ((Bool) -> Void)?) {
        self.dataWorker.deleteByLogout(complition: complition)
    }
    
}
