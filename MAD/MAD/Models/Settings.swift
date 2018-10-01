//
//  Settings.swift
//  MAD
//
//  Created by Student on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

public class Settings {
    
    public var name : String = "Michael Maxner"
    public var maxCalories : Int = 2500
    private var calorieBreakdown: CalorieBreakdown = CalorieBreakdown()
    
    private var currentCalories: Int = 0
    
    public static let instance = Settings()
    
    private init() {
    
    }
    
    public func consumeFood(food: Food)
    {
        food.calories
    }
    
}
