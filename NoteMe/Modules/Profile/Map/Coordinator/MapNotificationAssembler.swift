//
//  MapNotificationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit

final class MapNotificationAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: MapNotificationCoordinatorProtocol)
    -> UIViewController {
        
        let storage = MapNotificationStorage(service: container.resolve())
        
        let vm = MapNotificationVM(coordinator: coordinator,
                                   locationManager: .init(),
                                   storage: storage)
        return MapNotificationVC(viewModel: vm)
    }
    
}
