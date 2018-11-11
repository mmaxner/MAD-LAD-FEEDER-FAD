//
//  CustomBarButton.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-10.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable public class CustomBarButton : UIBarButtonItem {
    @IBInspectable public var buttonImage: UIImage! {
        didSet {
            setup()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        if let buttonImage = buttonImage {
            image = ResizeImage(image: buttonImage, targetSize: CGSize(width: 32, height: 32))?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    // Method used for mocking up the view in the Interface Builder
    override public func prepareForInterfaceBuilder() {
        setup()
    }
    
    // Source: https://iosdevcenters.blogspot.com/2015/12/how-to-resize-image-in-swift-in-ios.html
    private func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
