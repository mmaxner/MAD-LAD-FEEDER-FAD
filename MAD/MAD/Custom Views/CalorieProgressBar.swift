//
//  CircleProgressBar.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

@IBDesignable class CalorieProgressBar: UIView {
    
    private var percentageTxt: String!
    private var calorieTxt: String!
    private var displayCalorie: Bool = true
    
    // The calorie label for the Progress Bar
    public private(set) var calorieLbl: UILabel!
    
    @IBInspectable public var strokeWidth: CGFloat = 0.0 {
        didSet {
            createView()
        }
    }
    
    // MARK: - Progress Bar fields
    private var progressLayer = CAShapeLayer()

    // IBInspectable for the colors of the Progress Bar
    @IBInspectable public var lowProgressColor: UIColor!
    @IBInspectable public var mediumProgressColor: UIColor!
    @IBInspectable public var highProgressColor: UIColor!
    
    // MARK: - Track Bar fields
    private var trackLayer = CAShapeLayer()
    // IBInspectable for the color of the Progress Bar background
    @IBInspectable public var trackColor: UIColor! {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
            createView()
        }
    }

    // Required constructor for Storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    // Required constructor for Storyboard
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }
    
    // Method to call all other set up methods
    private func createView() {
        createProgressBar()
        createCalorieLabel()
    }
    
    // Creates the Circular Progress Bar
    // Source for code here: https://www.iostutorialjunction.com/2018/05/how-to-create-circular-progress-view-swift-tutorial.html
    private func createProgressBar() {
        backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        // Set the circle path as the path for the track, also setting the colors, width, and adding it as a sub layer
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor?.cgColor
        trackLayer.lineWidth = strokeWidth
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        // Set the circle path as the path for the progress bar, also setting the colors, width, and adding it as a sub layer
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = lowProgressColor?.cgColor
        progressLayer.lineWidth = strokeWidth
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
    }
    
    // Method to create the calorie label dynamically and center it
    private func createCalorieLabel() {
        let calorieLbl = UILabel()
        calorieLbl.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        calorieLbl.center.x = frame.minX + frame.width / 4
        calorieLbl.center.y = frame.minY - 15
        calorieLbl.font = calorieLbl.font.withSize(40.0)
        calorieLbl.textColor = UIColor.white
        calorieLbl.textAlignment = .center
        addSubview(calorieLbl)
        
        self.calorieLbl = calorieLbl
        // Add tap gesture recognizer to switch between displays
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleCalorieDisplay)))
    }
    
    // Method used for displaying the look of the Custom View in the Storyboard
    public override func prepareForInterfaceBuilder() {
        createView()
    }
    
    public func setProgress(calories: Int, maxCalories: Int) {
        let percentage = CGFloat(calories) / CGFloat(maxCalories)
        progressLayer.strokeEnd = percentage
        
        // Set medium color, only between the percentages of 40% to 85%
        if (percentage > 0.4 && percentage < 0.85) {
            let colorPercentage = percentage / 0.85
            progressLayer.strokeColor = mediumProgressColor.createInbetween(of: highProgressColor, by: colorPercentage).cgColor
        }
        // Set high color, when above 85%
        else if (percentage >= 0.85) {
            progressLayer.strokeColor = highProgressColor.cgColor
        }
        // Set the color to low to indicate something bad, if the user eats too many calories
        else if (percentage > 1.0) {
            progressLayer.strokeColor = lowProgressColor.cgColor
        }
        // Otherwise, set progress bar to low progress color
        else {
            let colorPercentage = percentage / 0.4
            progressLayer.strokeColor = lowProgressColor.createInbetween(of: mediumProgressColor, by: colorPercentage).cgColor
        }
        // Set different display texts
        calorieTxt = "\(calories) cal."
        percentageTxt = "\(Int(percentage * 100))%"
        
        calorieLbl.text = calorieTxt
    }
    
    // Toggles the display between the calorie amount and the percentage of daily calories met
    @objc public func toggleCalorieDisplay() {
        displayCalorie = !displayCalorie
        let displayText = displayCalorie ? calorieTxt : percentageTxt
        
        if let text = displayText {
            calorieLbl.fadeTo(text: text, for: CGFloat(Constants.FadeInTime * 2))
        }
    }
}
