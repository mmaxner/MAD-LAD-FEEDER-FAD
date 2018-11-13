//
//  FoodCardCell.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

public class FoodCardCell : UITableViewCell {
    
    @IBOutlet weak var foodNameLbl: UILabel!
    
    @IBOutlet weak var calorieValueLbl: UILabel!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var descTxtView: UITextView!
    @IBOutlet weak var highlightView: RoundedCardView!
    
    
    public var food: Food? {
        didSet {
            // Assign values from food to labels, after unwrapping food value
            if let food = food {
                isBlue = food.isSelected
                
                foodImg.image = food.image
                
                foodNameLbl.text = String(describing: food.name!)
                calorieValueLbl.text = "\(food.calorieBreakdown.totalCalories.internationalize!) kCal"
                
                descTxtView.text = food.description
                setupView()
            }
        }
    }
    
    // Public var for whether the cell is 'blue'.
    // Variables like 'selected' 'isSelected' 'highlighted' and 'isHighlighted' are all taken and changed by internal workings of a cell.
    public var isBlue: Bool = false {
        didSet {
            if (isBlue) {
                highlightView?.alpha = 1.0
            }
            else {
                highlightView?.alpha = 0.0
            }
        }
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Method to set up the round corners of the food image
    private func setupView() {
        foodImg?.clipsToBounds = true
        descTxtView?.textContainer.lineBreakMode = .byTruncatingTail
        highlightView?.alpha = 0.0
    }
    
}
