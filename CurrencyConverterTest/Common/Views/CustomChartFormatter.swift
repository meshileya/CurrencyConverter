//
//  CustomChartFormatter.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/7/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartFormatter: NSObject, IAxisValueFormatter{
    var workoutDuration = [String]()
    func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        print("THE VALUE ==> \(value) ==> \(workoutDuration.count)")
        if (workoutDuration.count == 1 ){
            return workoutDuration[0]
        }else{
            return workoutDuration[Int(value)]
        }
        
    }
    
    func setValues(values: [String]) {
        self.workoutDuration = values
    }
}
