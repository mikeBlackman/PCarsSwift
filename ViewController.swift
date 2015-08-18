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

    @IBOutlet var rpmView2: RpmView!
    @IBOutlet weak var gear: UITextField!
    @IBOutlet weak var speedo: UITextField!

    // insert url to local crest server here
    let url = "http://192.168.178.35:8080/crest/v1/api?carState=true"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        
        Alamofire.request(.GET, url)
            .responseJSON { _, _, JSONY, _ in
                
                var json = JSON(JSONY!)
                let carStateSpeed = json["carState"]["mSpeed"]
                let carSpeedMetersPerSecondDouble = carStateSpeed.double
                let speedkmph = carSpeedMetersPerSecondDouble! * 3.6
                let speedRounded = Int(round(speedkmph))
                
                //println(speedkmph)
                self.speedo.text = "\(speedRounded)"
                //"carState"
                
                let maxRpmJson = json["carState"]["mMaxRPM"]
                let currentRpmJson = json["carState"]["mRpm"]
                
                let maxRpm = maxRpmJson.intValue
                let currentRpm = currentRpmJson.intValue
                
                self.rpmView2.maxRpm = maxRpm
                self.rpmView2.currentRpm = currentRpm
                
                self.rpmView2.setNeedsDisplay()
                
                // set current gear
                
                let currentGear = json["carState"]["mGear"]
                
                let currentGearValue = currentGear.intValue
                
                if currentGearValue != 0 {
                
                self.gear.text = "\(currentGearValue)"
                } else {
                   self.gear.text = "N"
                }
        }
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
