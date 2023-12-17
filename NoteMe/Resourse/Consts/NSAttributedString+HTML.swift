//
//  NSAttributedString+HTML.swift
//  NoteMe
//
//  Created by George Popkich on 17.12.23.
//

import UIKit

extension NSAttributedString {
    
    static func parse(html: String, font: UIFont) -> NSAttributedString? {
        let fontFamilyName = font.familyName
        let fontSize = font.pointSize
        
        if
            let data = "<span style=\"font-family: '-apple-system', '\(fontFamilyName)'; font-size: \(fontSize)\">\(html)</span>"
                .data(using: .utf8) {
            return try? NSAttributedString(data: data,
                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                           documentAttributes: nil)
        }
        return nil
    }
    
}
