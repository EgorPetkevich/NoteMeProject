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
        let dataWorker = HomeDataWorker(dataWorker: container.resolve())
        
        let viewModel = HomeVM(adapter: adapter,
                               coordinator: coordinator,
                               frcService: makeFRC(),
                               dataWorker: dataWorker)

        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
    
    private static func makeFRC() -> FRCService<BaseNotificationDTO> {
        .init { request in
            request.predicate = .Notification.allNotComplited
            request.sortDescriptors = [.Notification.byDate]
        }
    }
    
}
