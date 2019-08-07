//
//  ApiService.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/6/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService{
    
    typealias CompletionHandler = (_ result: Bool, _ data: [RatesModel], _ error: Error?) -> Void
    
    var countryRates : [RatesModel] = []
    
    func currencyListCall(handler: @escaping CompletionHandler){
        //making a get request
        Alamofire.request("http://data.fixer.io/api/latest?access_key=2833e48ce65d1a8b9af390e88b954baa", method: .get, parameters: nil, headers : nil).validate().responseJSON
            {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let rates: Dictionary<String, JSON> = json["rates"].dictionaryValue
                    print("Data items count: \(rates.count)")
                    for item in rates { // loop through data items "  ".flag(country: model) + model + "    ▼"
                        self.countryRates.append(RatesModel(countryCode: item.key, countryRate: item.value.double ?? 0.0))
                    }
                    handler(true,self.countryRates, nil)
                case .failure(let error):
                    print(error)
                    handler(false,self.countryRates, nil)
                }
        }
    }
    
}
