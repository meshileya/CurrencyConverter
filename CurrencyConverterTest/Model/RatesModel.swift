//
//  RatesModel.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import RealmSwift

struct RatesModel {
    let countryCode : String
    let countryRate : Double
}

class Rates: Object {
    @objc dynamic var countryCode = ""
    @objc dynamic var currencyValue = 0.0
}
