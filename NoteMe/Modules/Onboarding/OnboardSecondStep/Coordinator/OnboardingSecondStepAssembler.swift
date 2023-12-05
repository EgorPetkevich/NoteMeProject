//
//  File.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import UIKit

final class OnboardSecondStepAssembler {
    
    private init() {}
    
    static func make(coordinator: OnboardSecondStepCoordinatorProtocol) -> UIViewController {
        let vm = OnboardingSecondStepVM(coordinator: coordinator)
        let vc = OnboardSecondStepVC(viewModel: vm)
        return vc
    }
    
}
