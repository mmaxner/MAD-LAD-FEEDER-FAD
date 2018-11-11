//
//  FoodCardCell.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

public class FoodCardCell : UICollectionViewCell {
    
    @IBOutlet weak var foodNameLbl: UILabel!
    
    @IBOutlet weak var calorieValueLbl: UILabel!
    @IBOutlet weak var carbValueLbl: UILabel!
    @IBOutlet weak var proteinValueLbl: UILabel!
    @IBOutlet weak var fatValueLbl: UILabel!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    public var food: Food? {
        didSet {
            // Assign values from food to labels, after unwrapping food value
            if let food = food {
                isBlue = food.isSelected
                
                foodImg.image = food.image
                
                foodNameLbl.text = String(describing: food.name!)
                calorieValueLbl.text = "\(food.calorieBreakdown.totalCalories)"
                carbValueLbl.text = "\(food.calorieBreakdown.totalCarbs)g"
                proteinValueLbl.text = "\(food.calorieBreakdown.totalProtein)g"
                fatValueLbl.text = "\(food.calorieBreakdown.totalFat)g"
                
                setupView()
            }
        }
    }
    
    // Public var for whether the cell is 'blue'.
    // Variables like 'selected' 'isSelected' 'highlighted' and 'isHighlighted' are all taken and changed by internal workings of a cell.
    public var isBlue: Bool = false {
        didSet {
            if (isBlue) {
                cardView?.backgroundColor = UIColor(red: 220/255, green: 235/255, blue: 255/255, alpha: 1.0)
            }
            else {
                cardView?.backgroundColor = UIColor.white
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Method to set up the round corners of the food image
    private func setupView() {
        self.backgroundColor = UIColor.clear
        foodImg?.layer.cornerRadius = 10.0
        foodImg?.clipsToBounds = true
    }
    
}
