//
//  CustomLabel.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/7/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.attributedText = attributedText
        }
    }
}
