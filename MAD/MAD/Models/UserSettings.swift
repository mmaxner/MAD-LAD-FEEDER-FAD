//
//  Settings.swift
//  MAD
//
//  Created by Student on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation

// Singleton class used to manage track the users calories and info
public class UserSettings {
    
    public static let instance = UserSettings()
    public var name : String = "Michael Macsner"
    public var maxCalories : Int = 2500
    public private(set) var calorieBreakdown: NutrionalFacts = NutrionalFacts()
    
    private init() {
    
    }
    
    public func consume(food: Food)
    {
        calorieBreakdown += food.calorieBreakdown
    }
    
}
