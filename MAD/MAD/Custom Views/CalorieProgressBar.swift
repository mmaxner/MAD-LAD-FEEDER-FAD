//
//  CircleProgressBar.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable
class CalorieProgressBar: UIView {
    private var calorieLbl: UILabel!
    
    /// MARK - Progress Bar fields
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
            createView()
        }
    }
    
    /// MARK - Track Bar fields
    private var tracklayer = CAShapeLayer()
    @IBInspectable public var trackColor: UIColor! {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
            createView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }
    
    private func createView() {
        createProgressBar()
        createCalorieLabel()
    }
    
    //https://www.iostutorialjunction.com/2018/05/how-to-create-circular-progress-view-swift-tutorial.html
    private func createProgressBar() {
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
    
    private func createCalorieLabel() {
        let calorieLbl = UILabel()
        calorieLbl.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        calorieLbl.center.x = frame.minX + frame.width / 4
        calorieLbl.center.y = frame.minY - 30
        calorieLbl.font = calorieLbl.font.withSize(40.0)
        calorieLbl.textColor = UIColor.white
        calorieLbl.textAlignment = .center
        addSubview(calorieLbl)
        
        self.calorieLbl = calorieLbl
    }
    
    public override func prepareForInterfaceBuilder() {
        createView()
    }
    
    public func set(calories: Int) {
        calorieLbl.text = "\(calories) cal."
    }
    
}
