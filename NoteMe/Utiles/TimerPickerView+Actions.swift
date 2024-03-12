//
//  TimerPickerView+Actions.swift
//  NoteMe
//
//  Created by George Popkich on 10.03.24.
//

import UIKit

@available(iOS 13.4, *)
extension TimerPickerView {
    
//    @discardableResult
//    func select(_ target: Any?,
//                _ selector: Selector,
//                for event: UIControl.Event = .valueChanged) -> TimerPickerView {
//        self.timerPicker.addTarget(target, action: selector, for: event)
//        return self
//    }
    
    @discardableResult
    func delegate(_ delegate: UIPickerViewDelegate?
                ) -> TimerPickerView {
        self.timerPickerViewDelegate = delegate
        return self
    }
    
    @discardableResult
    func setCancenButtonAction(_ target: Any?,
                _ selector: Selector,
                for event: UIControl.Event = .touchUpInside) -> TimerPickerView {
        self.cancelButton.addTarget(target, action: selector, for: event)
        return self
    }
    
    @discardableResult
    func setSelectButtonAction(_ target: Any?,
                _ selector: Selector,
                for event: UIControl.Event = .touchUpInside) -> TimerPickerView {
        self.selectButton.addTarget(target, action: selector, for: event)
        return self
    }
    
//    @discardableResult
//    func setDatePickerMode(_ date: UIDatePicker.Mode) -> TimerPickerView {
//        self.datePickerMode = date
//        return self
//    }
    
    @discardableResult
    func setDatePickerFrame(_ frame: CGRect) -> TimerPickerView {
        self.datePickerViewFrame = frame
        return self
    }
    
}


