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
    @IBInspectable var outlineColor: UIColor = UIColor.redColor()
    @IBInspectable var counterColor: UIColor = UIColor.grayColor()
    
    override func drawRect(rect: CGRect) {
        
        
        // DRAW OUTLINE
        
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let arcWidth: CGFloat = 76
        
        // 4
        let startAngle: CGFloat = π / 2
        let endAngle: CGFloat = (7 * π) / 4
        
        // 5
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        //1 - first calculate the difference between the two angles ensuring it is positive
        var angleDifference: CGFloat =  endAngle - startAngle
        
        //then calculate the arc for each rpm
        let arcLengthPerRpm = angleDifference / CGFloat(maxRpm)
        
        //then multiply out the angle by current rpm
        let outlineEndAngle = (arcLengthPerRpm * CGFloat(currentRpm) + startAngle)
        
        //2 - draw the outer arc
        var outlinePath = UIBezierPath(arcCenter: center,
            radius: bounds.width/2 - 2.5,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArcWithCenter(center,
            radius: bounds.width/2 - arcWidth + 2.5,
            startAngle: outlineEndAngle,
            endAngle: startAngle,
            clockwise: false)
        
        //4 - close the path
        outlinePath.closePath()
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
    }
}