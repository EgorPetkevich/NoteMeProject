//
//  TabBarAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

final class TabBarAssembler {
    private init() {}
    
    static func make(coordinator: TabBarCoordinatorProtocol) -> UIViewController {
        let vm = TabBarVM(coordinator: coordinator)
        let vc = TabBarVC(viewModel: vm)
        return vc
    }
}
