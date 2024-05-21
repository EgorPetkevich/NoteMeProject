//
//  MapNotificationInfoAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 22.04.24.
//

import UIKit


final class MapNotificationInfoAssembler {
    
    private init() {}
    
    static func makeMapNotificationInfoVC(title: String?,
                                          subtitle: String?) 
    -> UIViewController {
        
        let vm = MapNotificationInfoVM(title: title,
                                       subtitle: subtitle)
        let vc = MapNotificationInfoVC(viewModel: vm)
        
        return vc
    }
    
}
