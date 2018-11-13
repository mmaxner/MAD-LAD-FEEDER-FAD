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
    
    // Default food list
    public var foodList: [Food] = [
        Food(
            name: "Banana",
            image: #imageLiteral(resourceName: "Banana"),
            description: "Bananas have long been exploited by humans all the way back from 1800s, when French explorer Alexandre 'Anana found the first Banana.",
            calories: 50,
            protein: 0,
            fat: 2,
            carbs: 13
        ),
        Food(
            name: "Orange",
            image: #imageLiteral(resourceName: "Oranges"),
            description: "Named after the colour, tastes like it too!",
            calories: 70,
            protein: 12,
            fat: 3,
            carbs: 15
        ),
        Food(
            name: "Apple",
            image: #imageLiteral(resourceName: "Apple"),
            description: "Apples were first discovered by Newton, when he got hit by one.",
            calories: 20,
            protein: 1,
            fat: 0,
            carbs: 12
        ),
        Food(
            name: "Cucumber",
            image: #imageLiteral(resourceName: "Cucumber"),
            description: "The younger cousin of the Pickle, Cucumbers were discovered in Spain when Pickles were grown in soil that lacked 'pickle juice'.",
            calories: 5,
            protein: 0,
            fat: 0,
            carbs: 2
        ),
        Food(
            name: "Carrot",
            image: #imageLiteral(resourceName: "Carrots"),
            description: "Good for your eyes, bad for the Germans.",
            calories: 30,
            protein: 12,
            fat: 1000,
            carbs: 5
        ),
        Food(
            name: "Peas",
            image: #imageLiteral(resourceName: "Peas"),
            description: "Similar to a lentil, Peas are the worst vegetable taste wise, but very good nutrition wise.",
            calories: 6,
            protein: 2,
            fat: 0,
            carbs: 4
        ),
        Food(
            name: "Almonds",
            image: #imageLiteral(resourceName: "Almonds"),
            description: "The only milkable memeber of the Nut family, Almonds are said to be closer to mammals then legumes.",
            calories: 250,
            protein: 50,
            fat: 0,
            carbs: 2
        ),
        Food(
            name: "Cashews",
            image: #imageLiteral(resourceName: "Cashew"),
            description: "Famous south american nuts, Cashews are named after there Chewy consistency.",
            calories: 400,
            protein: 12,
            fat: 15,
            carbs: 20
        )
    ]
    
//    public let foodDictionary : [(name: String, list: [Food])] = [
//        // Name of the list, Fruit
//        (name: "Fruits", list: [
//            Food(
//                name: "Banana",
//                image: #imageLiteral(resourceName: "Banana"),
//                description: "Bananas have long been exploited by humans all the way back from 1800s, when French explorer Alexandre 'Anana found the first Banana.",
//                calories: 50,
//                protein: 0,
//                fat: 2,
//                carbs: 13
//            ),
//            Food(
//                name: "Orange",
//                image: #imageLiteral(resourceName: "Oranges"),
//                description: "Named after the colour, tastes like it too!",
//                calories: 70,
//                protein: 12,
//                fat: 3,
//                carbs: 15
//            ),
//            Food(
//                name: "Apple",
//                image: #imageLiteral(resourceName: "Apple"),
//                description: "Apples were first discovered by Newton, when he got hit by one.",
//                calories: 20,
//                protein: 1,
//                fat: 0,
//                carbs: 12
//            )
//            ]),
//        // Name of the list, Vegetables
//        (name: "Vegetables", list: [
//            Food(
//                name: "Cucumber",
//                image: #imageLiteral(resourceName: "Cucumber"),
//                description: "The younger cousin of the Pickle, Cucumbers were discovered in Spain when Pickles were grown in soil that lacked 'pickle juice'.",
//                calories: 5,
//                protein: 0,
//                fat: 0,
//                carbs: 2
//            ),
//            Food(
//                name: "Carrot",
//                image: #imageLiteral(resourceName: "Carrots"),
//                description: "Good for your eyes, bad for the Germans.",
//                calories: 30,
//                protein: 12,
//                fat: 1000,
//                carbs: 5
//            ),
//            Food(
//                name: "Peas",
//                image: #imageLiteral(resourceName: "Peas"),
//                description: "Similar to a lentil, Peas are the worst vegetable taste wise, but very good nutrition wise.",
//                calories: 6,
//                protein: 2,
//                fat: 0,
//                carbs: 4
//            )
//            ]),
//        // Name of the list, Nuts
//        (name: "Nuts", list: [
//            Food(
//                name: "Almonds",
//                image: #imageLiteral(resourceName: "Almonds"),
//                description: "The only milkable memeber of the Nut family, Almonds are said to be closer to mammals then legumes.",
//                calories: 250,
//                protein: 50,
//                fat: 0,
//                carbs: 2
//            ),
//            Food(
//                name: "Cashews",
//                image: #imageLiteral(resourceName: "Cashew"),
//                description: "Famous south american nuts, Cashews are named after there Chewy consistency.",
//                calories: 400,
//                protein: 12,
//                fat: 15,
//                carbs: 20
//            )
//            ])
//    ]
    
    private init() {
    
    }
    
    // Method used for the user consuming food, totals up the calorie break down / nutrional facts
    public func consume(food: Food) {
        calorieBreakdown += food.calorieBreakdown
    }
    
}
