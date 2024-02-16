//
//  KeyboardHelper+Time.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import Foundation

struct TimeNotificationKeyboardHelperUseCase:
    KeyboardHelperTimeNotificationUseCaseProtocol {
    
    private let keyboardHelper: KeyboardHelper
    
    init(keyboardHelper: KeyboardHelper) {
        self.keyboardHelper = keyboardHelper
    }
    
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper {
        keyboardHelper.onWillShow(handler)
    }
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper {
        keyboardHelper.onWillHide(handler)
    }
    
}
