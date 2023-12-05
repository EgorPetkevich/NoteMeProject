//
//  OnboardingSecondStepVM.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import Foundation

protocol OnboardSecondStepCoordinatorProtocol: AnyObject {
    func finish()
    func dissmissedByUser()
}

final class OnboardingSecondStepVM: OnboardSecondStepViewModelProtocol {
    
    private weak var coordinator: OnboardSecondStepCoordinatorProtocol?
    
    init(coordinator: OnboardSecondStepCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    func doneDidTap() {
        ParametersHelper.set(.onboardDidFinish, value: true)
        coordinator?.finish()
    }
    
    func dissmissedByUser() {
        coordinator?.dissmissedByUser()
    }
    
}
