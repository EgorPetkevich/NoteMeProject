//
//  AllNotificationStorage+Home.swift
//  NoteMe
//
//  Created by George Popkich on 26.03.24.
//

import Storage

extension AllNotificationStorage: HomeStorageUseCaseProtocol {
    
    func delete(dto: any DTODescription) {
        self.delete(dto: dto, complition: nil)
    }
    
}
