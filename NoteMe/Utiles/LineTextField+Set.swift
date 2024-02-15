//
//  TextField.swift
//  NoteMe
//
//  Created by George Popkich on 13.11.23.
//

import UIKit

extension LineTextField {
    
    @discardableResult
    func set(title: String?,
             placeholder: String?,
             errorText: String?) -> LineTextField {
        self.title = title
        self.placeholder = placeholder
        self.errorText = errorText
        return self
    }
    
    @discardableResult
    func setTitle(_ title: String) -> LineTextField {
        self.title = title
        return self
    }
    
    @discardableResult
    func setPlaceholder(_ placeholder: String) -> LineTextField {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func setErrorText(_ errorText: String?) -> LineTextField {
        self.errorText = errorText
        return self
    }
    
    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle?) -> LineTextField {
        self.borderStyle = borderStyle
        return self
    }
    
    @discardableResult
    func setInputView(_ inputView: UIView?) -> LineTextField {
        self.textFieldInputView = inputView
        return self
    }
    
}
