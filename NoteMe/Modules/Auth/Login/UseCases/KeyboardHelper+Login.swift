//
//  KeyboardHelper+Login.swift
//  NoteMe
//
//  Created by George Popkich on 26.11.23.
//

import Foundation

struct LoginKeyboardHelperUseCase: KeyboardHelperLoginUseCaseProtocol {
        
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


