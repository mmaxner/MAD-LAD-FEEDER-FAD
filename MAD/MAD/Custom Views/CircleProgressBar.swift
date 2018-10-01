//
//  CircleProgressBar.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable
public class CircleProgressBar: UIView {

    private var progressLayer = CAShapeLayer()
    public var progress: CGFloat {
        set {
            progressLayer.strokeEnd = newValue
        }
        get {
            return progressLayer.strokeEnd
        }
    }
    @IBInspectable public var progressColor: UIColor! {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
            createProgressBar()
        }
    }
    
    private var tracklayer = CAShapeLayer()
    @IBInspectable public var trackColor: UIColor! {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
            createProgressBar()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgressBar()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createProgressBar()
    }
    
    func createProgressBar() {
        backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor?.cgColor
        tracklayer.lineWidth = 10.0;
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor?.cgColor
        progressLayer.lineWidth = 10.0;
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
    }
    
}
