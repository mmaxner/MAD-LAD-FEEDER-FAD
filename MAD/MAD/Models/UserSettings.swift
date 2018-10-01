//
//  Settings.swift
//  MAD
//
//  Created by Student on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

public class UserSettings {
    
    public var name : String = "Michael Maxner"
    public var maxCalories : Int = 2500
    private var calorieBreakdown: NutrionalFacts = NutrionalFacts()
    
    private var currentCalories: Int = 0
    
    public static let instance = UserSettings()
    
    private init() {
    
    }
    
    public func consume(food: Food)
    {
        calorieBreakdown += food.calorieBreakdown
    }
    
}
