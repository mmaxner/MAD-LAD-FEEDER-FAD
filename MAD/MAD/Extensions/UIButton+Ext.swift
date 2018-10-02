//
//  UIButton+Ext.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func applyTintToImage(tint: UIColor) {
        let image = imageView?.image?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        tintColor = tint
    }
}
