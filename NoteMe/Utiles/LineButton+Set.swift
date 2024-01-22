//
//  LineButton+Set.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import UIKit

extension LineButton {
    
    @discardableResult
    func setButtonTitle(_ title: String) -> LineButton {
        self.button.setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    func setButtonImage(_ image: UIImage) -> LineButton {
        self.button.setImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    func setTarger(targer: Any?, selector: Selector) -> LineButton {
        button.withAction(target, selector)
        return self
    }
    
    @discardableResult
    func setTextColor(_ color: UIColor) -> LineButton {
        button.setTitleColor(color, for: .normal)
        return self
    }
    
    @discardableResult
    func setSeparator(_ isHidden: Bool) -> LineButton {
        separator.isHidden = isHidden
        return self
    }
    
    
}
