//
//  RoundedCardView.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable public class RoundedCardView: UIView {
    // The radius of the corners on the view
    @IBInspectable public var cornerRadius: CGFloat = 2.0 {
        didSet {
            roundCorners()
        }
    }
    
    // Required constructor for Storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundCorners()
    }
    
    // Required constructor for Storyboard
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        roundCorners()
    }
    
    public override func prepareForInterfaceBuilder() {
        roundCorners()
    }
    
    private func roundCorners() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
