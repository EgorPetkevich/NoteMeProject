//
//  HomeStorageStub.swift
//  NoteMeTests
//
//  Created by George Popkich on 26.03.24.
//

import UIKit
import Storage
@testable import NoteMe

final class HomeDataWorkerStub: HomeNotificationDataWorkerUseCaseProtocol {
    
    func deleteByUser(dto: any Storage.DTODescription) { }
    
}
