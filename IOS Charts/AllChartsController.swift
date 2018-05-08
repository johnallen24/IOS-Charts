//
//  AllChartsController.swift
//  IOS Charts
//
//  Created by John Allen on 5/7/18.
//  Copyright © 2018 jallen.studios. All rights reserved.
//

import UIKit
import Charts


class AllChartController: UIViewController {

    let chtChart: LineChartView = {
    let view = LineChartView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.noDataText = "Connect to sensor"
    view.noDataFont = NSUIFont(name: "HelveticaNeue", size: 18.0)
    return view
}()

let topContainer: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()
    
    let bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
let titleLabel: UITextView = {
    let textView = UITextView()
    textView.text = "Voltage"
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.textAlignment = .center
    textView.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 52)
    textView.isEditable = false
    textView.isScrollEnabled = false
    return textView
}()


let pieChart: KDCircularProgress = {
    let progress = KDCircularProgress()
    progress.startAngle = -90
    progress.progressThickness = 0.4
    progress.trackThickness = 0.6
    progress.clockwise = true
    progress.trackColor = UIColor.lightGray.withAlphaComponent(0.5)
    progress.gradientRotateSpeed = 2
    progress.roundedCorners = false
    progress.glowMode = .noGlow
    progress.glowAmount = 0.9
    progress.translatesAutoresizingMaskIntoConstraints = false
    return progress
}()

let horizontalProgressBar: GTProgressBar = {
    let progressBar = GTProgressBar()
    progressBar.translatesAutoresizingMaskIntoConstraints = false
    progressBar.backgroundColor = UIColor.white
    progressBar.progress = 1
    progressBar.barBorderWidth = 1
    progressBar.barFillInset = 2
    progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
    progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    progressBar.font = UIFont.boldSystemFont(ofSize: 18)
    progressBar.labelPosition = GTProgressBarLabelPosition.top
    progressBar.barMaxHeight = 20 //12
    progressBar.direction = GTProgressBarDirection.clockwise
    progressBar.orientation = .horizontal
    progressBar.displayLabel = false
    return progressBar
}()

let verticalProgressBar: GTProgressBar = {
    let progressBar = GTProgressBar()
    progressBar.translatesAutoresizingMaskIntoConstraints = false
    progressBar.backgroundColor = UIColor.white
    progressBar.progress = 1
    progressBar.barBorderWidth = 1
    progressBar.barFillInset = 2
    progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
    progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    progressBar.font = UIFont.boldSystemFont(ofSize: 18)
    progressBar.labelPosition = GTProgressBarLabelPosition.top
    progressBar.barMaxWidth = 60
    progressBar.direction = GTProgressBarDirection.clockwise
    progressBar.orientation = .vertical
    progressBar.displayLabel = false
    return progressBar
}()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
         var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        horizontalProgressBar.barBorderColor = colorWithHexString(hexString: "#fe117c")
        horizontalProgressBar.barFillColor = colorWithHexString(hexString: "#fe117c")
        horizontalProgressBar.barBackgroundColor = colorWithHexString(hexString: "#fe117c").withAlphaComponent(0.2)
        verticalProgressBar.barBorderColor = colorWithHexString(hexString: "#fe117c")
        verticalProgressBar.barFillColor = colorWithHexString(hexString: "#fe117c")
        verticalProgressBar.barBackgroundColor = colorWithHexString(hexString: "#fe117c").withAlphaComponent(0.2)
        pieChart.set(colors: colorWithHexString(hexString: "#fe117c"))
        setupViews()
    }

    
    
     func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(topContainer)
        view.addSubview(bottomContainer)
        topContainer.addSubview(chtChart)
        topContainer.addSubview(pieChart)
        bottomContainer.addSubview(horizontalProgressBar)
        bottomContainer.addSubview(verticalProgressBar)
        
        titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
        
        
        horizontalProgressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        horizontalProgressBar.heightAnchor.constraint(equalTo: bottomContainer.heightAnchor, multiplier: 0.05).isActive = true
        horizontalProgressBar.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 0).isActive = true
        horizontalProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        
        topContainer.topAnchor.constraint(equalTo: horizontalProgressBar.bottomAnchor, constant: 0).isActive = true
        topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
        
        bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 0).isActive = true
        bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
       bottomContainer.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
        
        
        chtChart.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 0).isActive = true
        
        chtChart.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 0).isActive = true
        chtChart.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 0).isActive = true
        chtChart.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: 0).isActive = true
        chtChart.backgroundColor = UIColor.white
        
        
        pieChart.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 0).isActive = true
        pieChart.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor, constant: 0).isActive = true
        pieChart.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 0).isActive = true
       pieChart.widthAnchor.constraint(equalTo: bottomContainer.widthAnchor, multiplier: 0.5).isActive = true
        
        pieChart.backgroundColor = UIColor.white
        
        
        
        verticalProgressBar.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 0).isActive = true
        verticalProgressBar.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor, constant: 0).isActive = true
        verticalProgressBar.leadingAnchor.constraint(equalTo: pieChart.trailingAnchor, constant: 0).isActive = true
        verticalProgressBar.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: 0).isActive = true
        
        verticalProgressBar.barMaxHeight = view.bounds.height
    
    }

    var times: [Double] = [] //holds time at every sensor value
    var sensorValues: [Double] = [] //holds all values from LoPy
    var totalXmoved = 0.0
    var totalValues = 0
   
    
    
    @objc func update() {
         let number = Double(arc4random_uniform(5)) + Double(Float(arc4random()) / Float(UINT32_MAX)).rounded(toPlaces: 2)
        titleLabel.text = "Voltage: \(number)"
        let percentage = number / 5.0
        let angle = percentage * 360
        pieChart.animate(toAngle: angle, duration: 0.75, completion: nil)
        horizontalProgressBar.animateTo(progress: CGFloat(percentage))
        verticalProgressBar.animateTo(progress: CGFloat(percentage))
        
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
        
        
        chtChart.chartDescription?.text = ""
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






extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
}
}








