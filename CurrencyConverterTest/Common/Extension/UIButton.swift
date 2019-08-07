//
//  UIButton.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}
