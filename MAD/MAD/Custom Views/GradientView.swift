//
//  GradientView.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable public class GradientView : UIView {
    // Public inspectable of a UIColor, can be changed in the Interface Builder
    @IBInspectable public var colorOne: UIColor! {
        didSet {
            updateLayer()
        }
    }
    // Public inspectable of a UIColor, can be changed in the Interface Builder
    @IBInspectable public var colorTwo: UIColor! {
        didSet {
            updateLayer()
        }
    }
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateLayer()
    }
    
    private func updateLayer() {
        backgroundColor = UIColor.clear
        // Set the layer as a CAGradientLayer, then set the two colors as the gradients colors
        if let gradientLayer = self.layer as? CAGradientLayer,
            let colorOne = colorOne, let colorTwo = colorTwo {
            gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        }
    }
    
    // Method used for mocking up the view in the Interface Builder
    override public func prepareForInterfaceBuilder() {
        updateLayer()
    }
}
