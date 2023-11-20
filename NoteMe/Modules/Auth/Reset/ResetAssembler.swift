//
//  ResetAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 21.11.23.
//

import UIKit

final class ResetAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let vm = ResetVM(inputValidator: InputValidator(),
                         resetAuthService: TESTResetAuthService())
        let vc = ResetVC(viewModel: vm)
        
        return vc
    }
}

final class TESTResetAuthService: ResetAuthServiceUseCase {
    func reset(email: String?, complition: @escaping (Bool) -> Void) {
        complition(true)
    }
    
    
}
