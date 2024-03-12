//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import UIKit
import Storage

final class HomeAssembler {
    
    private init() {}
        
    static func make(coordinator: HomeCoordinatorProtocol,
                     container: Container
    ) -> UIViewController {
        let adapter = HomeAdapter()
        let storage: AllNotificationStorage = container.resolve()
        
        let viewModel = HomeVM(adapter: adapter,
                               storage: storage,
                               coordinator: coordinator,
                               frcService: makeFRC())

        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
    
    private static func makeFRC() -> FRCService<BaseNotificationDTO> {
        .init { request in
            request.predicate = .Notification.allNotCompleted
            request.sortDescriptors = [.Notification.byDate]
        }
    }
    
}
