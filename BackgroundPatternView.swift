//
//  BackgroundPatternView.swift
//  PCarsSwift
//
//  Created by Mike Blackman on 16/08/15.
//  Copyright (c) 2015 Mike Blackman. All rights reserved.
//

import UIKit

class BackgroundPatternView: UIView {
    
    func radians (degrees : Double) -> Double {
        return degrees * M_PI/180;
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        self.backgroundColor = UIColor.redColor()

    }
}
