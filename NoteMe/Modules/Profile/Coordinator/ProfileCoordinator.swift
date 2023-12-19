//
//  ProfileCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        return ProfileAssembler.make()
    }
    
}
