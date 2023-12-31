//
//  UIButton+Styles.swift
//  NoteMe
//
//  Created by George Popkich on 31.10.23.
//

import UIKit

extension UIButton {
    
    static func yellowRoundedButton(_ title: String?) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .appYellow
        button.cornerRadius = 5.0
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appText, for: .normal)
        button.setTitleColor(
            .appText.withAlphaComponent(0.75),
            for: .highlighted)
        button.titleLabel?.font = UIFont.appBoldFont(17.0)
        return button
    }
    
    static func cancelButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        button.cornerRadius = 5.0
        button.setBorder(width: 1.0, color: .appYellow)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(
            .appYellow.withAlphaComponent(0.75),
            for: .highlighted)
        button.titleLabel?.font = UIFont.appBoldFont(17.0)
        return button
    }
    
    static func underlineyellowButton (_ title: String) -> UIButton {
        return underlineButton(title,
                               color: .appYellow,
                               font: .appBoldFont(17.0))
    }
    
    static func underlineGrayButton(_ title: String) -> UIButton {
        return  underlineButton(title,
                                color: .appGrayText,
                                font: .appBoldFont(15.0))
    }
    
    static func underlineButton(
            _ title: String,
            color: UIColor,
            font: UIFont
        ) -> UIButton {
            let button = UIButton()
            button.backgroundColor = .clear
            let normalAttr: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: color,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: color
            ]
            button.setAttributedTitle(
                .init(string: title, attributes: normalAttr),
                for: .normal
            )
            let highlightedAttr: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: color.withAlphaComponent(0.75),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: color.withAlphaComponent(0.75)
            ]
            button.setAttributedTitle(
                .init(string: title, attributes: highlightedAttr),
                for: .highlighted
            )
            return button
        }
    
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
        value: NSUnderlineStyle.single.rawValue,
        range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}
