//
//  String+Locale.swift
//  NoteMe
//
//  Created by George Popkich on 4.11.23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    //MARK: Auth
    enum Auth {}
    
    //MARK: Onboarding
    enum Onboarding {}
    
}
