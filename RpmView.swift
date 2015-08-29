//
//  RpmView.swift
//  PCarsSwift
//
//  Created by Mike Blackman on 12/08/15.
//  Copyright (c) 2015 Mike Blackman. All rights reserved.
//

import UIKit

let π:CGFloat = CGFloat(M_PI)

@IBDesignable class RpmView: UIView {
    
    @IBInspectable var maxRpm: Int = 9000
    @IBInspectable var currentRpm: Int = 0
    @IBInspectable var overlayColor: UIColor = UIColor.redColor()
    @IBInspectable var backingColor: UIColor = UIColor.grayColor()
    
    override func drawRect(rect: CGRect) {
        
        // Draw Background Stroke
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = π / 2
        let endAngle: CGFloat = (7 * π) / 4
        
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        path.lineWidth = arcWidth
        backingColor.setStroke()
        path.stroke()
        
        // Draw the actual rpm outline
        let angleDifference: CGFloat =  endAngle - startAngle
        let arcLengthPerRpm = angleDifference / CGFloat(maxRpm)
        let outlineEndAngle = (arcLengthPerRpm * CGFloat(currentRpm) + startAngle)
    
        var path2 = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)
        
        path2.lineWidth = arcWidth
        overlayColor.setStroke()
        path2.stroke()
    }
}
