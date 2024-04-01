//
//  LocationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 11.03.24.
//

import UIKit

final class LocationAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: LocationCoordinatorProtocol,
                     locationProperties: LocationProperties?,
                     delegate: LocationDelegate) -> UIViewController {
        
        let adapter = SearchLocationAdapter()
        let locationService = LocationNetworkServiceUseCase(service: container.resolve())
        
        let vm = LocationVM(adapter: adapter,
                            locationService: locationService,
                            coordinator: coordinator,
                            locationProperties: locationProperties,
                            delegate: delegate)
        
        return LocationVC(viewModel: vm)
    }
    
}
