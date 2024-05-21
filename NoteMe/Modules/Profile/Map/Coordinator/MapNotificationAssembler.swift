//
//  MapAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit

final class MapAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: MapCoordinatorProtocol) -> UIViewController {
        
        let vm = MapVM(coordinator: coordinator,
                       locationManager: .init())
        return MapVC(viewModel: vm)
    }
    
}
