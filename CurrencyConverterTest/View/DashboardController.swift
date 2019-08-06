//
//  DashboardController.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class DashboardController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    lazy var firstCurrencyField : CustomTextField = {
        let field = CustomTextField.create(title: "", placeholder: "")
        field.keyboardType = .asciiCapable
        return field
    }()
}
