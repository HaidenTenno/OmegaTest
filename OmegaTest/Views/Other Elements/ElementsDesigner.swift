//
//  TextFieldDesigner.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import UIKit

final class ElementsDesigner {
    
    static func getDesignedTextField(placeholder: String, delegate: UITextFieldDelegate) -> UITextField {
        let textField = UITextFieldPadding(top: 0, left: 10, bottom: 0, right: 10)
        textField.backgroundColor = Design.Colors.fieldBackground
        textField.layer.cornerRadius = 10.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = Design.Colors.fieldBorderAndText.cgColor
        textField.textColor = Design.Colors.fieldBorderAndText
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: Design.Colors.fieldPlaceholder
        ])
        textField.addDoneButtonOnKeyboard()
        textField.delegate = delegate
        return textField
    }
    
    static func getApplyDesignedButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = Design.Colors.applyButtonBackground
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = Design.Colors.applyButtonBorder.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 20,bottom: 10,right: 20)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Design.Fonts.MiniHeader.color, for: .normal)
        button.titleLabel?.font = Design.Fonts.MiniHeader.font
        return button
    }
    
    static func getSmallButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Design.Fonts.RegularText.color, for: .normal)
        button.titleLabel?.font = Design.Fonts.RegularText.font
        return button
    }
}
