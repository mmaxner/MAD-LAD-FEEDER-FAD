//
//  CustomToolbar.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-12.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable public class CustomToolbar: UIToolbar {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func prepareForInterfaceBuilder() {
        setup()
    }
    
    public func setup() {
//        self.layer.borderColor = tintColor.cgColor
//        self.layer.borderWidth = 1.0
        self.backgroundColor = UIColor.clear
        self.setBackgroundImage(UIImage(),
                                        forToolbarPosition: .any,
                                        barMetrics: .default)
        self.setShadowImage(UIImage(), forToolbarPosition: .any)
        
    }
}
