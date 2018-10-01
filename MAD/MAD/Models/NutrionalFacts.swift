//
//  CalorieBreakdown.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

public struct NutrionalFacts {
    var totalCalories: Int = 0
    var totalProtein: Int = 0
    var totalCarbs: Int = 0
    var totalFat: Int = 0
    
    static func +=(lhs: inout NutrionalFacts, rhs: NutrionalFacts)
    {
        lhs.totalCalories += rhs.totalCalories
        lhs.totalCarbs += rhs.totalCarbs
        lhs.totalFat += rhs.totalFat
        lhs.totalProtein += rhs.totalProtein
    }
}
