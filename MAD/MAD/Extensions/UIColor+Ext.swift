//
//  UIColor+Ext.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

// Extenions for UIColor
extension UIColor {
    
    // Method used to create a balance between the current color and another one,
    // with a percentage value represening how much of the other color this one should move towards
    public func createInbetween(of otherColor: UIColor, by percentage: CGFloat) -> UIColor {
        
        // Calculate the inbetween values for each but only increment at a percentage of the value
        let red = closeDifference(between: self.red, and: otherColor.red, by: percentage)
        let blue = closeDifference(between: self.blue, and: otherColor.blue, by: percentage)
        let green = closeDifference(between: self.green, and: otherColor.green, by: percentage)
        
        return UIColor(red: red, green: green, blue: blue, alpha: cgColor.alpha)
    }
    
    // Private func for calculating the difference between two CGFloat values and then creating a percentage of that difference
    private func closeDifference(between valueOne: CGFloat, and valueTwo:CGFloat, by percentage: CGFloat) -> CGFloat {
        var newValue = valueOne
        let difference = valueTwo - valueOne
        newValue += (difference * CGFloat(percentage))
        
        return newValue
    }
    
    /* Easy access methods below for R,G,B values. These values are not easily accessible on a normal UIColor object,
     * and accessing a UIColor's .ciColor is not always plausible as it is dependent other values of the UIColor.
     */
    
    // Easy access computed value for a Colors red value.
    public var red: CGFloat {
        return CIColor(color: self).red
    }
    
    // Easy access computed value for a Colors green value.
    public var blue: CGFloat {
        return CIColor(color: self).blue
    }
    
    // Easy access computed value for a Colors blue value.
    public var green: CGFloat {
        return CIColor(color: self).green
    }
}
