//
//  LocationCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 11.03.24.
//

import UIKit

final class LocationCoordinator: Coordinator {
    
    private let container: Container
    private var delegate: LocationDelegate
    private var locationProperties: LocationProperties?
    
    init(container: Container,
         delegate: LocationDelegate,
         locationProperties: LocationProperties?) {
        self.container = container
        self.delegate = delegate
        self.locationProperties = locationProperties
    }
    
    override func start() -> UIViewController {
        let vc = LocationAssembler.make(container: container,
                                        coordinator: self,
                                        locationProperties: locationProperties,
                                        delegate: delegate)
        return vc
    }
}

extension LocationCoordinator: LocationCoordinatorProtocol {
    
}
