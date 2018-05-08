import UIKit

class ProgressBarController: UIViewController {
    
    let progressBar: GTProgressBar = {
        let view = GTProgressBar()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(progressBar)
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateGraph), userInfo: nil, repeats: true)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
        
        progressBar.backgroundColor = UIColor.white
        progressBar.progress = 1
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        progressBar.font = UIFont.boldSystemFont(ofSize: 18)
        progressBar.labelPosition = GTProgressBarLabelPosition.top
        progressBar.barMaxHeight = 12
        progressBar.direction = GTProgressBarDirection.clockwise
        progressBar.orientation = .horizontal
        progressBar.barMaxHeight = 400
        progressBar.barMaxWidth = 20
       
    }
    
    var i = 0
    @objc func updateGraph() {
        let number = Double(arc4random_uniform(5)) + Double(Float(arc4random()) / Float(UINT32_MAX)).rounded(toPlaces: 2)
        let percentage = number / 5.0
        
        progressBar.animateTo(progress: CGFloat(percentage))
        
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
