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
        let alertService = ProfileAlertService(service: container.resolve())
        let vm = ProfileVM(coordinator: coordinator,
                           authService: authService,
                           adapter: ProfileAdapter(),
                           alertService: alertService)
        return ProfileVC(viewModel: vm)
    }
    
}
