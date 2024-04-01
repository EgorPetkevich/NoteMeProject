//
//  HomeAdapterSpy.swift
//  NoteMeTests
//
//  Created by George Popkich on 26.03.24.
//

import UIKit
import Storage
@testable import NoteMe

final class HomeAdapterSpy: HomeAdapterProtocol {
    
    var reloadDataDTOList: [any DTODescription] = []
    var reloadDataCalled: Bool = false
    
    func reloadDate(_ dtoList: [any DTODescription]) {
        reloadDataCalled = true
        reloadDataDTOList = dtoList
    }
    
    func makeTableView() -> UITableView {
        .init()
    }
    
    var tapButtonOnDTO: ((UIButton, any DTODescription) -> Void)?
    
    var filterDidSelect: ((NoteMe.NotificationFilterType) -> Void)?
    
}
