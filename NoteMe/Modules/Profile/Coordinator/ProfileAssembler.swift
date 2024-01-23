//
//  ProfileAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

final class ProfileAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: ProfileCoordinatorProtocol) -> UIViewController {
        
        let authService = ProfileAuthServiceUseCase(authService: container.resolve())
        
        let vm = ProfileVM(coordinator: coordinator, authService: authService)
        return ProfileVC(viewModel: vm)
    }
    
}
