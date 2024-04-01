//
//  HomeFRCServiceSpy.swift
//  NoteMeTests
//
//  Created by George Popkich on 26.03.24.
//

import Foundation
import Storage
@testable import NoteMe

final class HomeFRCServiceSpy: HomeFRCServiceUseCaseProtocol {
    
    var startHandleCalled: Bool = false
    
    var fetchedDTOs: [any DTODescription] = []
    
    var didChangeContent: (([any DTODescription]) -> Void)?
    
    func startHandle() {
        startHandleCalled = true
    }
    
    
}
