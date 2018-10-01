//
//  Food.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

public struct Food {
    public var calorieBreakdown : CalorieBreakdown!
    public var name : String!
    
    init(name: String, calories: Int, protein: Int, fat: Int, carbs: Int) {
        self.name = name
        
        calorieBreakdown = CalorieBreakdown()
        calorieBreakdown.totalCalories = calories
        calorieBreakdown.totalCarbs = carbs
        calorieBreakdown.totalFat = fat
        calorieBreakdown.totalProtein = protein
    }
}
