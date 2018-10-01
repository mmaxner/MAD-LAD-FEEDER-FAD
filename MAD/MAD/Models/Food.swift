//
//  Food.swift
//  MAD
//
//  Created by 🅱️onnor 🅱️enry on 2018-10-01.
//  Copyright © 2018 🅱️onner 🅱️enry. All rights reserved.
//

import Foundation

public struct Food {
    public var calorieBreakdown : NutritionalFacts!
    public var name : String!
    
    init(name: String, calories: Int, protein: Int, fat: Int, carbs: Int) {
        self.name = name
        
        calorieBreakdown = NutritionalFacts()
        calorieBreakdown.totalCalories = calories
        calorieBreakdown.totalCarbs = carbs
        calorieBreakdown.totalFat = fat
        calorieBreakdown.totalProtein = protein
    }
}
