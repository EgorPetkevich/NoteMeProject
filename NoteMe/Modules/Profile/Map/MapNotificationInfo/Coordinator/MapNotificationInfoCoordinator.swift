//
//  MapNotificationInfoCoordinator.swift
//  NoteMe
//
//  Created by George Popkich on 22.04.24.
//

import UIKit

final class MapNotificationInfoCoordinator: Coordinator {
    
    private var title: String?
    private var subtitle: String?
    
    init(title: String? = nil, 
         subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    override func start() -> UIViewController {
        let vc = MapNotificationInfoAssembler
            .makeMapNotificationInfoVC(title: title,
                                       subtitle: subtitle)
        return vc
    }
    
}
