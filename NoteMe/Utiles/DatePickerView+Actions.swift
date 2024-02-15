//
//  UIDatePicker+Select.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit

@available(iOS 13.4, *)
extension DatePickerView {
    
    @discardableResult
    func select(_ target: Any?,
                _ selector: Selector,
                for event: UIControl.Event = .valueChanged) -> DatePickerView {
        self.datePicker.addTarget(target, action: selector, for: event)
        return self
    }
    
    @discardableResult
    func setCancenButtonAction(_ target: Any?,
                _ selector: Selector,
                for event: UIControl.Event = .touchUpInside) -> DatePickerView {
        self.cancelButton.addTarget(target, action: selector, for: event)
        return self
    }
    
    @discardableResult
    func setSelectButtonAction(_ target: Any?,
                _ selector: Selector,
                for event: UIControl.Event = .touchUpInside) -> DatePickerView {
        self.selectButton.addTarget(target, action: selector, for: event)
        return self
    }
    
    @discardableResult
    func setDatePickerMode(_ date: UIDatePicker.Mode) -> DatePickerView {
        self.datePickerMode = date
        return self
    }
    
    @discardableResult
    func setDatePickerFrame(_ frame: CGRect) -> DatePickerView {
        self.datePickerViewFrame = frame
        return self
    }
    
}


