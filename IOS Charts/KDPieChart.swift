//
//  KDPieChart.swift
//  IOS Charts
//
//  Created by John Allen on 5/7/18.
//  Copyright © 2018 jallen.studios. All rights reserved.
//

import UIKit

class KDPieChart: UIViewController {
    
    var progress: KDCircularProgress!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress.startAngle = -90
        progress.progressThickness = 0.4
        progress.trackThickness = 0.6
        progress.clockwise = true
        progress.trackColor = UIColor.lightGray.withAlphaComponent(0.5)
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .noGlow
        progress.glowAmount = 0.9
        progress.set(colors: colorWithHexString(hexString: "#fe117c"))
        progress.center = CGPoint(x: view.center.x, y: view.center.y + 25)
        view.addSubview(progress)
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateGraph), userInfo: nil, repeats: true)
        
    }
    
    var i = 0
    @objc func updateGraph() {
         let number = Double(arc4random_uniform(5)) + Double(Float(arc4random()) / Float(UINT32_MAX)).rounded(toPlaces: 2)
        let percentage = number / 5.0
        let angle = percentage * 360
        progress.animate(toAngle: angle, duration: 0.75, completion: nil)
       
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
