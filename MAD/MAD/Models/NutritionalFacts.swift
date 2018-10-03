//
//  CalorieBreakdown.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

// Struct used for storing Calories, Carbs, Protein, and Fat values
public struct NutritionalFacts {
    var totalCalories: Int = 0
    var totalProtein: Int = 0
    var totalCarbs: Int = 0
    var totalFat: Int = 0
    
    // Custom add operator, adds the values of the two structs together
    static func +=(lhs: inout NutritionalFacts, rhs: NutritionalFacts) {
        lhs.totalCalories += rhs.totalCalories
        lhs.totalCarbs += rhs.totalCarbs
        lhs.totalFat += rhs.totalFat
        lhs.totalProtein += rhs.totalProtein
    }
}
