//
//  Food.swift
//  MAD
//
//  Created by Conner Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit
import CoreData

// Class for storing the information on different food
public class Food {
    public var calorieBreakdown : NutritionalFacts!
    public var name : String!
    public var image: UIImage?
    public var isSelected: Bool = false
    public var description: String!
    
//    public var coreData: NSManagedObject {
//        
//    }
    
    init(info: FoodInfo) {
        name = info.name
        description = info.desc
        if let data = info.image {
            image = UIImage(data: data)
        }
        
        calorieBreakdown = NutritionalFacts()
        calorieBreakdown.totalCalories = Int(info.calories)
        calorieBreakdown.totalProtein = Int(info.protein)
        calorieBreakdown.totalCarbs = Int(info.carbs)
        calorieBreakdown.totalFat = Int(info.fat)
    }
    
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
