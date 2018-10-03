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
    // Default Name
    public var name : String = "Michael Macsner"
    // Default calories value
    public var maxCalories : Int = 2500
    // Struct of Calories, Carbs, Protein, and Fat that the user has consumed. Is only settable in this class
    public private(set) var calorieBreakdown: NutritionalFacts = NutritionalFacts()
    
    private init() {
    
    }
    
    // Method used for the user consuming food, totals up the calorie break down / nutrional facts
    public func consume(food: Food) {
        calorieBreakdown += food.calorieBreakdown
    }
    
}
