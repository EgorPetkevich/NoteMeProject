//
//  DataWorker+Login.swift
//  NoteMe
//
//  Created by George Popkich on 7.05.24.
//

import Foundation

struct LoginDataWorker: NotificationDataWorkerLoginUseCaseProtocol {
    
    private let service: NotificationDataWorker
    
    init(service: NotificationDataWorker) {
        self.service = service
    }
    
    func restore(completion: ((Bool) -> Void)?) {
        self.service.restore(complition: completion)
    }
    
}
