//
//  ProfileAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 19.12.23.
//

import UIKit

final class ProfileAssembler {
    
    private init() {}
    
    static func make(coordinator: ProfileCoordinatorProtocol) -> UIViewController {
        let vm = ProfileVM(coordinator: coordinator, authService: AuthService())
        return ProfileVC(viewModel: vm)
    }
    
}
