//
//  HomeVM.swift
//  NoteMe
//
//  Created by George Popkich on 13.02.24.
//

import UIKit
import Storage

protocol HomeAdapterProtocol: AnyObject {
    func reloadDate(_ dtoList: [any DTODescription])
}

final class HomeVM: HomeViewModelProtocol {
    
    private let frsService: FRCService<DateNotificationDTO>
    private let adapter: HomeAdapterProtocol
    
    init(frsService: FRCService<DateNotificationDTO>,
         adapter: HomeAdapterProtocol) {
        self.frsService = frsService
        self.adapter = adapter
        
        bind()
    }
    
    private func bind() {
        frsService.didChangeContent = { [weak adapter] dtoList in
            adapter?.reloadDate(dtoList)
        }
    }
}
