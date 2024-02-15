//
//  DateNotificationKeyboardHelperUseCase.swift
//  NoteMe
//
//  Created by George Popkich on 12.02.24.
//

import Foundation

struct DateNotificationKeyboardHelperUseCase: KeyboardHelperDateNotificationUseCaseProtocol {
    
    private let keyboardHelper: KeyboardHelper
    
    init(keyboardHelper: KeyboardHelper) {
        self.keyboardHelper = keyboardHelper
    }
    
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper {
        keyboardHelper.onWillShow(handler)
    }
    
}
