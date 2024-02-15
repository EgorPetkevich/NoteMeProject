//
//  UIDatePicker.swift
//  NoteMe
//
//  Created by George Popkich on 11.02.24.
//

import UIKit
extension UIDatePicker {
    
    static func genrateDatePicker(whith mode: UIDatePicker.Mode) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            fatalError("Error DatePicker version")
        }
        return datePicker
    }
    
}
