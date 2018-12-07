//
//  Settings.swift
//  MAD
//
//  Created by Student on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// Singleton class used to manage track the users calories and info
public class UserSettings {
    
    public static let instance = UserSettings()
    
    private var userData: User!
    
    // Default Name
    public var name : String! {
        didSet {
            if let userData = userData {
                userData.name = name
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
    }
    // Default calories value
    public var maxCalories : Int! {
        didSet {
            if let userData = userData {
                userData.max_calories = Int32(maxCalories)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
    }
    // Struct of Calories, Carbs, Protein, and Fat that the user has consumed. Is only settable in this class
    public private(set) var calorieBreakdown: NutritionalFacts = NutritionalFacts()
    
    // Default food list
    public var foodList = [Food]()
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        createFoodData(with: context)
        createUserData(with: context)
        
        foodList.sort(by: { $0.name <= $1.name })
    }
    
    private func createFoodData(with context: NSManagedObjectContext) {
        // Request for FoodInfo entities
        let foodRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodInfo")
        foodRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(foodRequest)
            if let foods = result as? [FoodInfo] {
                // If the user has no food saved already...
                if foods.count == 0 {
                    // Create foods
                    let foodList: [Food] = [
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
                            name: NSLocalizedString("Peas", comment: ""),
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
                    )]
                    
                    // Create Core Data entity for each food item
                    if let foodEntity = NSEntityDescription.entity(forEntityName: "FoodInfo", in: context) {
                        for food in foodList {
                            // Set values for foodinfo the same as food
                            let foodInfo = NSManagedObject(entity: foodEntity, insertInto: context)
                            foodInfo.setValue(food.name, forKey: "name")
                            foodInfo.setValue(food.description, forKey: "desc")
                            if let image = food.image {
                                foodInfo.setValue(UIImagePNGRepresentation(image), forKey: "image")
                            }
                            foodInfo.setValue(food.calorieBreakdown.totalCalories, forKey: "calories")
                            foodInfo.setValue(food.calorieBreakdown.totalCarbs, forKey: "carbs")
                            foodInfo.setValue(food.calorieBreakdown.totalFat, forKey: "fat")
                            foodInfo.setValue(food.calorieBreakdown.totalProtein, forKey: "protein")

                            self.foodList.append(food)
                        }
                        // Save context
                        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                    }
                }
                // If food is saved, load it
                else {
                    for data in foods {
                        foodList.append(Food(info: data))
                    }
                }
            }
        }
        catch {
            print("Failed to load or create Food items from CoreData")
        }
    }
    
    private func createUserData(with context: NSManagedObjectContext) {
        // Request for the user entity
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(userRequest)
            if let user = result as? [User] {
                // If user does exist,
                if user.count == 1 {
                    self.userData = user[0]
                    
                    // Set values for name and max calories
                    name = userData.value(forKey: "name") as? String ?? "Conner"
                    maxCalories = userData.value(forKey: "max_calories") as? Int ?? 2500
                    let calories = userData.value(forKey: "calories") as? Int ?? 0
                    let fat = userData.value(forKey: "fat") as? Int ?? 0
                    let carbs = userData.value(forKey: "carbs") as? Int ?? 0
                    let protein = userData.value(forKey: "protein") as? Int ?? 0
                    
                    calorieBreakdown = NutritionalFacts(totalCalories: calories, totalProtein: protein, totalCarbs: carbs, totalFat: fat)
                }
                // if the user does not exist, create
                else if let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context) {
                    // Create values
                    userData = NSManagedObject(entity: userEntity, insertInto: context) as? User
                    if  userData != nil {
                        userData.name = name
                        userData.max_calories = Int32(maxCalories)
                        userData.calories = Int32(calorieBreakdown.totalCalories)
                        userData.carbs = Int32(calorieBreakdown.totalCalories)
                        userData.fat = Int32(calorieBreakdown.totalFat)
                        userData.protein = Int32(calorieBreakdown.totalProtein)
                    }
                }
            }
        } catch {
            print("Failed to perform request.")
        }
    }
    
    // Method used for the user consuming food, totals up the calorie break down / nutrional facts
    public func consume(food: Food) {
        calorieBreakdown += food.calorieBreakdown
        
        if let userData = userData, let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            userData.calories = Int32(calorieBreakdown.totalCalories)
            userData.carbs = Int32(calorieBreakdown.totalCalories)
            userData.fat = Int32(calorieBreakdown.totalFat)
            userData.protein = Int32(calorieBreakdown.totalProtein)
            
            appDelegate.saveContext()
        }
    }
    
    public func update(food: Food, name: String, description: String, image: UIImage, macros: NutritionalFacts) {
        // Get the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error within app delegate, could not parse to type AppDelegate")
            return
        }
        
        // Make a request for all entity objects that are FoodInfo...
        let context = appDelegate.persistentContainer.viewContext
        let foodRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodInfo")
        foodRequest.returnsObjectsAsFaults = false
        
        do {
            // Parse the results back
            if let results = try context.fetch(foodRequest) as? [FoodInfo] {
                for foodEntity in results {
                    // And find the entity that matches the food we are updating
                    if foodEntity.name == food.name {
                        foodEntity.calories = Int32(macros.totalCalories)
                        foodEntity.carbs = Int32(macros.totalCarbs)
                        foodEntity.fat = Int32(macros.totalFat)
                        foodEntity.protein = Int32(macros.totalProtein)
                        
                        foodEntity.image = UIImagePNGRepresentation(image)
                        foodEntity.desc = description
                        foodEntity.name = name
                        
                        break
                    }
                }
                // Update actual food item
                appDelegate.saveContext()
                food.name = name
                food.description = description
                food.image = image
                food.calorieBreakdown = macros
                
                // Resort
                foodList.sort(by: { $0.name <= $1.name })
            }
        }
        catch {
            print("Error fetching the food list when updating")
        }
    }
    
    public func add(food: Food) {
        // Get the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error within app delegate, could not parse to type AppDelegate")
            return
        }
        // Add to list and sort
        foodList.append(food)
        foodList.sort(by: { $0.name <= $1.name })
        
        let context = appDelegate.persistentContainer.viewContext
        // Create core data of food
        if let foodEntity = NSEntityDescription.entity(forEntityName: "FoodInfo", in: context) {
            let foodInfo = NSManagedObject(entity: foodEntity, insertInto: context)
            foodInfo.setValue(food.name, forKey: "name")
            foodInfo.setValue(food.description, forKey: "desc")
            if let image = food.image {
                foodInfo.setValue(UIImagePNGRepresentation(image), forKey: "image")
            }
            foodInfo.setValue(food.calorieBreakdown.totalCalories, forKey: "calories")
            foodInfo.setValue(food.calorieBreakdown.totalCarbs, forKey: "carbs")
            foodInfo.setValue(food.calorieBreakdown.totalFat, forKey: "fat")
            foodInfo.setValue(food.calorieBreakdown.totalProtein, forKey: "protein")
            
            appDelegate.saveContext()
        }
    }
}
