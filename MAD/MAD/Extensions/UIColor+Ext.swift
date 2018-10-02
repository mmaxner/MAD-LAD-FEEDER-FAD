//
//  UIColor+Ext.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

extension UIColor {
    public func createInbetween(of otherColor: UIColor, by percentage: CGFloat) -> UIColor {
        
        // Calculate the inbetween values for each but only increment at a percentage of the value
        let red = closeDifference(between: self.red, and: otherColor.red, by: percentage)
        let blue = closeDifference(between: self.blue, and: otherColor.blue, by: percentage)
        let green = closeDifference(between: self.green, and: otherColor.green, by: percentage)
        
        return UIColor(red: red, green: green, blue: blue, alpha: cgColor.alpha)
    }
    
    private func closeDifference(between valueOne: CGFloat, and valueTwo:CGFloat, by percentage: CGFloat) -> CGFloat {
        var newValue = valueOne
        let difference = valueTwo - valueOne
        newValue += (difference * CGFloat(percentage))
        
        return newValue
    }
    
    public var red: CGFloat {
        return CIColor(color: self).red
    }
    
    public var blue: CGFloat {
        return CIColor(color: self).blue
    }
    
    public var green: CGFloat {
        return CIColor(color: self).green
    }
}
