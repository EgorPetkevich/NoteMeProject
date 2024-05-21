//
//  MapCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit

final class MapCoordinator: Coordinator {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = MapAssembler.make(container: container,
                                    coordinator: self)
        return vc
    }
    
}

extension MapCoordinator: MapCoordinatorProtocol {
    
}
