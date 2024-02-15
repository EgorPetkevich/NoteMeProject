//
//  LineTextView+Set.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit

extension LineTextView {
    
    @discardableResult
    func setTitle(_ title: String) -> LineTextView {
        self.title = title
        return self
    }
    
    func setPlaceholder(_ placeholder: String) -> LineTextView {
        self.placeholder = placeholder
        return self
    }
    
}
