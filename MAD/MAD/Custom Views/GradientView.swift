//
//  GradientView.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable
public class GradientView : UIView {
    @IBInspectable public var solidColor: UIColor!
//    @IBInspectable public var colorTwo: UIColor!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let gradientLayer = self.layer as? CAGradientLayer
        {
            gradientLayer.colors = [
                solidColor.cgColor,
                UIColor.init(white: 1, alpha: 0).cgColor
            ]
        }
        backgroundColor = UIColor.clear
    }
}
