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
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
