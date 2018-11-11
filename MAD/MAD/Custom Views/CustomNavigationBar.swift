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
    
    public func setTitle(title: String) {
        if let titleItem = topItem {
            titleItem.title = title
        }
    }
    
    public func toggleTitle(on: Bool) {
        if let titleItem = topItem {
            titleItem.titleView?.isHidden = !on
        }
    }
    
    public func fadeTo(text: String, for duration: CGFloat) {
        // Fade away and set text on completion
        UIView.animate(withDuration: TimeInterval(duration/2), delay: 0.5, options: [.curveEaseInOut], animations: {
            self.toggleTitle(on: false)
        }, completion: { finished in
            self.setTitle(title: text)
        })
        
        // Fade back in
        UIView.animate(withDuration: TimeInterval(duration/2), animations: {
            self.toggleTitle(on: true)
        })
    }
    
    private func setup() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.tintColor = UIColor.white;
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.titleTextAttributes = textAttributes

    }
    
    // Method used for mocking up the view in the Interface Builder
    override public func prepareForInterfaceBuilder() {
        setup()
    }
}
