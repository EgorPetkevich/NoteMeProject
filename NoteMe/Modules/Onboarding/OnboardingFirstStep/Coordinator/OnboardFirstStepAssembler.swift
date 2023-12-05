//
//  OnboardFirstStepAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import UIKit

final class OnboardFirstStepAssembler {
    
    private init() {}
    
    static func make(_ coordinator: OnboardFirstStepCoordinatorProtocol) -> UIViewController {
        let vm = OnboardingFirstStepVM(coordinator: coordinator)
        let vc = OnboardFirstStepVC(viewModel: vm)
        return vc
    }
    
}
