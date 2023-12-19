//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return HomeAssembler.make()
    }
    
}

