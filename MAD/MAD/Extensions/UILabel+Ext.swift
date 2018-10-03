//
//  UILabel+Ext.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

// Extensions for UILabel
extension UILabel {
    
    // Method used for easily animating the label fading away, and fading back in with new text
    public func fadeTo(text: String, for duration: CGFloat) {
        // Fade away and set text on completion
        UIView.animate(withDuration: TimeInterval(duration/2), delay: 0.5, options: [.curveEaseInOut], animations: {
            self.alpha = 0.0
        }, completion: { finished in
            self.text = text
        })
        
        // Fade back in
        UIView.animate(withDuration: TimeInterval(duration/2), animations: {
            self.alpha = 1.0
        })
    }
    
}
