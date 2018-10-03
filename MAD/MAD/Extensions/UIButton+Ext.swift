//
//  UIButton+Ext.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

// Extensions for UIButton
extension UIButton {
    
    // Method for taking a buttons image view and adding a tint to it
    public func applyTintToImage(tint: UIColor) {
        let image = imageView?.image?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        tintColor = tint
    }
}
