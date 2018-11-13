//
//  Food.swift
//  MAD
//
//  Created by Conner Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

// Class for storing the information on different food
public class Food {
    public var calorieBreakdown : NutritionalFacts!
    public var name : String!
    public var image: UIImage?
    public var isSelected: Bool = false
    public var description: String!
    
    init(name: String, image: UIImage?, description:String?, calories: Int, protein: Int, fat: Int, carbs: Int) {
        self.name = name
        self.image = image
        self.description = description
        
        calorieBreakdown = NutritionalFacts()
        calorieBreakdown.totalCalories = calories
        calorieBreakdown.totalCarbs = carbs
        calorieBreakdown.totalFat = fat
        calorieBreakdown.totalProtein = protein
    }
    
    init(name: String, image: UIImage?, description:String?, macros: NutritionalFacts) {
        self.name = name
        self.image = image
        self.description = description
        
        calorieBreakdown = macros
    }
}
