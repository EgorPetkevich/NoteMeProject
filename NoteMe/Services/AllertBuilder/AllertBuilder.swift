//
//  AllertBuilder.swift
//  NoteMe
//
//  Created by George Popkich on 5.12.23.
//

import UIKit

final class AlertBuilder {
    
    typealias AlertActionhandler = () -> Void
    
    static func build(title: String?,
                      message: String?,
                      cancelTitle: String? = nil,
                      cancelHeldler: AlertActionhandler? = nil,
                      okTitle: String? = nil,
                      okHeldler: AlertActionhandler? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        if let cancelTitle {
            let action = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelHeldler?()
            }
            alertVC.addAction(action)
        }
        
        if let okTitle {
            let action = UIAlertAction(title: okTitle, style: .default) { _ in
                okHeldler?()
            }
            alertVC.addAction(action)
        }
        
        return alertVC
    }
    
}
