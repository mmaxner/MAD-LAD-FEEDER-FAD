//
//  CustomButton.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-10.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable public class CustomButton : UIButton {
    
    @IBInspectable public var colorOne: UIColor! {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var colorTwo: UIColor! {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var inverse: Bool = false {
        didSet {
            setup()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        if let colorOne = colorOne, let colorTwo = colorTwo {
            
            self.layer.cornerRadius = 5.0
            self.layer.borderWidth = 2.5
            if (!inverse) {
                self.tintColor = colorOne
                self.layer.borderColor = self.tintColor.cgColor
                
                self.setTitleColor(tintColor, for: .normal)
            
                self.backgroundColor = colorTwo
            }
            else {
                self.tintColor = colorTwo
                self.setTitleColor(tintColor, for: .normal)
                
                self.layer.borderColor = colorOne.cgColor
                self.backgroundColor = colorOne
            }
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        setup()
    }
}
