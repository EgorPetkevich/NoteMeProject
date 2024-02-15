//
//  PopNotificationAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 15.02.24.
//

import UIKit

final class PopNotificationSelectorAssembler {
    
    private init() {}
    
    static func make(container: Container,
                     coordinator: PopNotificationSelectorCoordinatorProtocol,
                     select: PopNotificationSections) -> UIViewController {

        let vm = PopNotificationSelectorVM(adapter: PopNotificationAdapter(),
                                           select: select,
                                           coordinator: coordinator)
        let vc = PopNotificationSelectorVC(viewModel: vm)
        return vc
    }
    
}
