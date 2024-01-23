//
//  KeyboardHelper+Reset.swift
//  NoteMe
//
//  Created by George Popkich on 26.11.23.
//

import Foundation

struct ResetKeyboardHelperRegisterUseCase: KeyboardHelperResetUseCaseProtocol {
    
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
