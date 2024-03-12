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
        
        let vm = LocationVM(coordinator: coordinator,
                            locationProperties: locationProperties,
                            delegate: delegate)
        
        return LocationVC(viewModel: vm)
    }
    
}
