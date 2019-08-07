//
//  GetChartData.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/7/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [Double])
    var dateData: [String] {get set}
    var currencyRate: [Double] {get set}
}
