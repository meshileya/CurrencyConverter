//
//  LocalDb.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/7/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class LocalDb{
    
    func getLocalData() -> Results<Rates>{
        return try! Realm().objects(Rates.self)
    }
}
