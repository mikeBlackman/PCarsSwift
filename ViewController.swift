//
//  ViewController.swift
//  PCarsSwift
//
//  Created by Mike Blackman on 10/08/15.
//  Copyright (c) 2015 Mike Blackman. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var rpmView2: RpmView!
    @IBOutlet weak var gear: UITextField!
    @IBOutlet weak var speedo: UITextField!
    @IBOutlet weak var absText: UITextField!
    
    @IBOutlet weak var leftFrontWear: UITextField!
    @IBOutlet weak var rightFrontWear: UITextField!
    @IBOutlet weak var rightRearWear: UITextField!
    @IBOutlet weak var leftRearWear: UITextField!
    
    

    // insert url to local crest server here
    let url = "http://192.168.178.35:8080/crest/v1/api?carState=true&wheelsAndTyres=true"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "carbonFiber.png")!)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        
<<<<<<< HEAD
        Alamofire.request(.GET, url).responseJSON { _, _, jsonResponse, _ in
            
            let json = JSON(jsonResponse!)
            
            // KMPH
            let carSpeedMetersPerSecond = json["carState"]["mSpeed"].double
            let speedkmph = carSpeedMetersPerSecond! * 3.6
            let speedRounded = Int(round(speedkmph))
            self.speedo.text = "\(speedRounded)"
            
            // RPM
            let maxRpm = json["carState"]["mMaxRPM"].intValue
            let currentRpm = json["carState"]["mRpm"].intValue
            self.rpmView2.maxRpm = maxRpm
            self.rpmView2.currentRpm = currentRpm
            self.rpmView2.setNeedsDisplay()
            
            // GEAR
            let currentGear = json["carState"]["mGear"].intValue
            if currentGear != 0 {
                self.gear.text = "\(currentGear)"
            } else if currentGear == 0 {
                self.gear.text = "N" // Display N for neutral
            } else {
                self.gear.text = "R" // Display R for reverse
            }
            
            // ABS
            let absStatus = json["carState"]["mAntiLockActive"].bool
            
            if absStatus != nil && absStatus! {
                self.absText.textColor = UIColor.greenColor()
            } else if absStatus != nil && !absStatus! {
                self.absText.textColor = UIColor.grayColor()
            }
            
            // Tyre Wear
            let leftFrontTyreWear = self.calcTyreWearPercentage(json["wheelsAndTyres"]["mTyreWear"][0].double!)
            let rightFrontTyreWear = self.calcTyreWearPercentage(json["wheelsAndTyres"]["mTyreWear"][1].double!)
            let leftRearTyreWear = self.calcTyreWearPercentage(json["wheelsAndTyres"]["mTyreWear"][2].double!)
            let rightRearTyreWear = self.calcTyreWearPercentage(json["wheelsAndTyres"]["mTyreWear"][3].double!)
            
            self.leftFrontWear.text = "\(leftFrontTyreWear)"
            self.rightFrontWear.text = "\(rightFrontTyreWear)"
            self.leftRearWear.text = "\(leftRearTyreWear)"
            self.rightRearWear.text = "\(rightRearTyreWear)"
            
=======
        Alamofire.request(.GET, url)
            .responseJSON { _, _, jsonResponse, _ in
                
                let json = JSON(jsonResponse!)
                
                let carSpeedMetersPerSecond = json["carState"]["mSpeed"].double
                let speedkmph = carSpeedMetersPerSecond! * 3.6
                let speedRounded = Int(round(speedkmph))
                
                self.speedo.text = "\(speedRounded)"
                
                let maxRpm = json["carState"]["mMaxRPM"].intValue
                let currentRpm = json["carState"]["mRpm"].intValue
                
                self.rpmView2.maxRpm = maxRpm
                self.rpmView2.currentRpm = currentRpm
                
                self.rpmView2.setNeedsDisplay()
                
                let currentGear = json["carState"]["mGear"].intValue
                
                if currentGear != 0 {
                    self.gear.text = "\(currentGear)"
                } else {
                   self.gear.text = "N" // Display N for neutral
                }
>>>>>>> origin/master
        }
    }
    
    
    func calcTyreWearPercentage (value : Double) -> Int {
        let percentage = (1 - value) * 100;
        return Int(percentage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
