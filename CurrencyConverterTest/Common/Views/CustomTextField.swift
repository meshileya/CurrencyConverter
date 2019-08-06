//
//  CustomTextField.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

class CustomTextField: SkyFloatingLabelTextField {
    private let leftPadding = CGFloat(6)
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }
    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: leftPadding, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: leftPadding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    
    
}

extension SkyFloatingLabelTextField {
    
    static func create(title: String, placeholder: String? = nil) -> CustomTextField {
        let field = CustomTextField(frame: .zero)
        field.placeholder = placeholder ?? title
        field.title = title
        field.titleFormatter = { $0 }
        field.lineView.isHidden = true
        field.selectedTitleColor = UIColor.lightGray
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .textBackgroundColor()
        field.heightAnchor.constraint(equalToConstant: 38).isActive = true
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.textBorderColor().cgColor
        field.font = UIFont.systemFont(ofSize: 15)

        return field
    }
    
    
    static func createWithIcon(title: String, placeholder: String? = nil) -> SkyFloatingLabelTextField{
        
        let textField = SkyFloatingLabelTextField(frame: .zero)
        textField.placeholder = placeholder ?? title
        textField.title = title
        textField.selectedTitleColor = UIColor.lightGray
        textField.font = UIFont.systemFont(ofSize: 15)
        
        return textField
    }
}
