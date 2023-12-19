//
//  ResetAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import UIKit

final class ResetAssembler {
    
    private init() {}
    
    static func make(coordinator: ResetCoordinatorProtocol) -> UIViewController {
        let vm = ResetVM(inputValidator: InputValidator(),
                         resetAuthService: AuthService(),
                         coordinator: coordinator,
                         keyboardHelper: KeyboardHelper(),
                         alertService: AlertService.current)
        let vc = ResetVC(viewModel: vm)
        
        return vc
    }
    
}

