//
//  CustomNavigationBar.swift
//  MAD
//
//  Created by Student on 2018-11-10.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomNavigationBar : UINavigationBar {
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
    
    // Method used for mocking up the view in the Interface Builder
    override public func prepareForInterfaceBuilder() {
        setup()
    }
}
