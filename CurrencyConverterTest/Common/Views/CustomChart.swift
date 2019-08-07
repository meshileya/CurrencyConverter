//
//  CustomChart.swift
//  CurrencyConverterTest
//
//  Created by TECHIES on 8/7/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit
import Charts

class LineChart: UIView{
    
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    var dateData = [String]()
    var currencyRate = [Double]()
    
    var delegate: GetChartData!{
        didSet{
            populateData()
            lineChartSetup()
        }
        
    }
    
    func populateData(){
        currencyRate = delegate.currencyRate
        dateData = delegate.dateData
    }
    
    func lineChartSetup(){
        self.backgroundColor = UIColor.white
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        
        setLineChart(dataPoints: dateData, values: currencyRate)
        
    }
    func cublicLineChartSetup(){
        self.backgroundColor = UIColor.white
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
    }
    
    func setLineChart(dataPoints: [String], values: [Double]){
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "No data for the chart"
        lineChartView.backgroundColor = #colorLiteral(red: 0.1874557436, green: 0.5683380365, blue: 0.9868627191, alpha: 1)
        
        for i in 0..<dataPoints.count{
            let dataPoint = ChartDataEntry(x: Double(i), y: values[i])
            print("Hello, \(values[i])!")
            lineDataEntry.append(dataPoint)
        }
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "Get rates alert straight into your inbox")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.lightGray]
        chartDataSet.setCircleColor(UIColor.white)
        //            chartDataSet.circleHoleColor(UIColor.black)
        chartDataSet.circleRadius = 4.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = true
        
        
        chartDataSet.valueFont = UIFont(name: "Helvetica", size: 12.0)!
        
        let gradientColors = [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            return
        }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xAxis: XAxis = XAxis()
        xAxis.valueFormatter = formatter as! IAxisValueFormatter
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.centerAxisLabelsEnabled = false
        lineChartView.xAxis.setLabelCount(3, force: true)
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.valueFormatter = xAxis.valueFormatter
        lineChartView.chartDescription?.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.data = chartData
        
    }
}
