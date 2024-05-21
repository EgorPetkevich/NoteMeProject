//
//  MapNotificationInfoVM.swift
//  NoteMe
//
//  Created by George Popkich on 22.04.24.
//

import UIKit

final class MapNotificationInfoVM: MapNotificationInfoViewModelProtocol {
    
    var title: String?
    var subtitle: String?
    
    init(title: String?,
         subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
    
}
