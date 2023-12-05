//
//  OnboardingFirstStepVM.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import Foundation

protocol OnboardFirstStepCoordinatorProtocol: AnyObject {
    func openNextStep()
}

final class OnboardingFirstStepVM: OnboardFirstStepViewModelProtocol {
    
    private weak var coordinator: OnboardFirstStepCoordinatorProtocol?
    
    init(coordinator: OnboardFirstStepCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    func nextDidTap() {
        coordinator?.openNextStep()
    }
    
    
}
