//
//  ViewController.swift
//  IOS Charts
//
//  Created by John Allen on 5/4/18.
//  Copyright © 2018 jallen.studios. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    
    var times: [Double] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16] //holds time at every sensor value
    var sensorValues: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] //holds all values from LoPy
    var totalXmoved = 0.0
    
    let chtChart: LineChartView = {
        let view = LineChartView()
        view.noDataText = "Connect to sensor"
        view.noDataFont = NSUIFont(name: "HelveticaNeue", size: 18.0)
        return view
    }()
    
    let topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UITextView = {
        let textView = UITextView()
        textView.text = "Voltage"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chtChart)
        
        
        view.addSubview(topContainer)
        topContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
        
        topContainer.addSubview(titleLabel)
       
        titleLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 0).isActive = true
        
        
        chtChart.chartDescription?.text = ""
        chtChart.translatesAutoresizingMaskIntoConstraints = false
        chtChart.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 0).isActive = true
        chtChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        chtChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        chtChart.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        updateGraph()
    }

    var totalValues = 17
   
    
    @objc func update() {
        let number = arc4random_uniform(20)
        times.append(Double(totalValues))
        totalValues = 1 + totalValues
        sensorValues.append(Double(number))
        updateGraph()
    }
    
    var firstTime = true
    
    func updateGraph() {
       

        
        var lineChartEntry  = [ChartDataEntry]()
        
        for i in 0..<times.count {
            
            let value = ChartDataEntry(x: times[i], y: sensorValues[i])
            
            lineChartEntry.append(value)
        }
        
        let chartDataSet = LineChartDataSet(values: lineChartEntry, label: "Voltage")
        let chartData = LineChartData()
        
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false)
        chartDataSet.colors = [colorWithHexString(hexString: "#fe117c")]
        chartDataSet.setCircleColor(colorWithHexString(hexString: "#fe117c"))
        chartDataSet.circleHoleColor = colorWithHexString(hexString: "#fe117c")
        //#03C03C
        chartDataSet.circleRadius = 5
        //chartDataSet.circleHoleRadius = 3
        //chartDataSet.circleHoleColor  = UIColor.white
        
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.lineWidth = 2
        chartDataSet.mode = .horizontalBezier
    
        
        if(firstTime){
            chtChart.animate(xAxisDuration: 1, easingOption: .easeInCubic)
            firstTime = false
            chtChart.moveViewToAnimated(xValue: 16, yValue: 0, axis: YAxis.AxisDependency.left, duration: 1, easing: nil)
        }
        
        chtChart.xAxis.labelPosition = .bottom
        chtChart.xAxis.drawGridLinesEnabled = false
        chtChart.chartDescription?.enabled = true
        chtChart.legend.enabled = true
        chtChart.rightAxis.enabled = false
        chtChart.setVisibleXRange(minXRange: 0, maxXRange: 14)
        chtChart.leftAxis.labelFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
        chtChart.xAxis.labelFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
        chtChart.leftAxis.drawAxisLineEnabled = false
       
        
        chtChart.leftAxis.drawGridLinesEnabled = true
        chtChart.leftAxis.drawLabelsEnabled = true
        chtChart.leftAxis.gridColor = NSUIColor.gray.withAlphaComponent(0.4)
        chtChart.data = chartData
        
        
        
        if (times.count > 14)
        {
            //chtChart.moveViewToX(totalXmoved)
            chtChart.moveViewToAnimated(xValue: totalXmoved, yValue: 0, axis: YAxis.AxisDependency.left, duration: 1, easing: nil)

            totalXmoved += 1.0
        }
        
        
    }
    
    func colorWithHexString(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    
}

