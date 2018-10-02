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
    
    @IBOutlet weak var carbValueLbl: UILabel!
    @IBOutlet weak var proteinValueLbl: UILabel!
    @IBOutlet weak var fatValueLbl: UILabel!
    
    public var food: Food? {
        didSet {
            // Do the stuff
            if let food = food {
                foodNameLbl.text = String(describing: food.name!)
                carbValueLbl.text = "\(food.calorieBreakdown.totalCarbs)g"
                proteinValueLbl.text = "\(food.calorieBreakdown.totalProtein)g"
                fatValueLbl.text = "\(food.calorieBreakdown.totalCarbs)g"
            }
        }
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
