import UIKit
import Charts

class PieChartController: UIViewController, ChartViewDelegate {
    
    
    var times: [Double] = [1,2] //holds time at every sensor value
    var sensorValues: [Double] = [1,2]
    
    let chtChart: PieChartView = {
        let view = PieChartView()
        //view.noDataText = "Connect to sensor"
        //view.noDataFont = NSUIFont(name: "HelveticaNeue", size: 18.0)
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
        
        chtChart.translatesAutoresizingMaskIntoConstraints = false
        chtChart.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 0).isActive = true
        chtChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        chtChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        chtChart.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateGraph), userInfo: nil, repeats: true)
        chtChart.delegate = self
        
        
    }
    
    var firstTime = true
    var maxY = 14
    @objc func updateGraph()
    {
        let number = Double(arc4random_uniform(5)) + Double(Float(arc4random()) / Float(UINT32_MAX)).rounded(toPlaces: 2)
        let oppositeNumber = 5.0 - number
        sensorValues[0] = number
        sensorValues[1] = oppositeNumber
        
        titleLabel.text = "Voltage: \(Double(number))"
//        if (firstTime)
//        {
            var dataEntry: [PieChartDataEntry] = []
            for i in 0..<times.count {
                
                let value = PieChartDataEntry(value: sensorValues[i])
                dataEntry.append(value)
            }
            
            
            let chartDataSet = PieChartDataSet(values: dataEntry, label: "BPM")
            chartDataSet.colors = [UIColor.blue, UIColor.clear]
            let chartData = PieChartData ()
            
            
            chartData.addDataSet(chartDataSet)
            
            
            
            //chtChart.animate(yAxisDuration: 1, easingOption: .easeOutBack)
            
            chtChart.legend.enabled = true
            chtChart.chartDescription?.text = ""
            
            //chartDataSet.colors = [colorWithHexString(hexString: "#fe117c"), UIColor.blue]
            //chtChart.setVisibleXRange(minXRange: 1, maxXRange: 4)
            
            chtChart.data = chartData
            firstTime = false
        
       // }
        
        
       
        //add half of visible range to full visible range and then subtract number
       
        //chtChart.setVisibleYRange(minYRange: 0, maxYRange: 5, axis: YAxis.AxisDependency.left)
        
        
        maxY = 1 + maxY
        
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



extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

