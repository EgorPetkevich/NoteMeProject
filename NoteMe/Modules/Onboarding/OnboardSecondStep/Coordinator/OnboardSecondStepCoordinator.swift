//
//  OnboardSecondStepCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import UIKit


final class OnboardSecondStepCoordinator: Coordinator {
    
    var onDismissedByUser: ((Coordinator) -> Void)?
    
    override func start() -> UIViewController {
        let vc = OnboardSecondStepAssembler.make(coordinator: self)
        return vc
    }
    
}


extension OnboardSecondStepCoordinator: OnboardSecondStepCoordinatorProtocol {
    
    func dissmissedByUser() {
        onDismissedByUser?(self)
    }
    
}
