//
//  FoodListViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Not Conner Henry. All rights reserved.
//

import UIKit

class FoodListViewController: UITableViewController  {
    private var toggleEatButton: ((Bool) -> ())?
    public private(set) var selectedFoods: [Food]!
    // Set the sections of Food available, which is a list of names (String) and an array of Foods
    let foodDictionary : [(name: String, list: [Food])] = [
        // Name of the list, Fruit
        (name: "Fruits", list: [
            Food(name: "Banana", image: #imageLiteral(resourceName: "Banana"), calories: 50, protein: 0, fat: 2, carbs: 13),
            Food(name: "Orange", image: #imageLiteral(resourceName: "Oranges"), calories: 70, protein: 12, fat: 3, carbs: 15),
            Food(name: "Apple", image: #imageLiteral(resourceName: "Apple"), calories: 20, protein: 1, fat: 0, carbs: 12)
        ]),
        // Name of the list, Vegetables
        (name: "Vegetables", list: [
            Food(name: "Cucumber", image: #imageLiteral(resourceName: "Cucumber"), calories: 5, protein: 0, fat: 0, carbs: 2),
            Food(name: "Carrot", image: #imageLiteral(resourceName: "Carrots"), calories: 30, protein: 12, fat: 1000, carbs: 5),
            Food(name: "Peas", image: #imageLiteral(resourceName: "Peas"), calories: 6, protein: 2, fat: 0, carbs: 4)
        ]),
        // Name of the list, Nuts
        (name: "Nuts", list: [
            Food(name: "Almonds", image: #imageLiteral(resourceName: "Almonds"), calories: 250, protein: 50, fat: 0, carbs: 2),
            Food(name: "Cashews", image: #imageLiteral(resourceName: "Cashew"), calories: 400, protein: 12, fat: 15, carbs: 20)
        ])
    ]
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: "FoodCardView", bundle: nil), forCellReuseIdentifier: "FoodCardView")
        selectedFoods = [Food]()
    }
    
    public func setToggleEatButton(method: @escaping ((Bool) -> ())) {
        toggleEatButton = method
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section <= foodDictionary.count ? foodDictionary[section].name : nil
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return foodDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section <= foodDictionary.count ? foodDictionary[section].list.count : 0
    }
    
    // Binds FoodCardCells to the food items in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCardView", for: indexPath) as? FoodCardCell {
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            cell.food = foodDictionary[indexPath.section].list[indexPath.row]
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    // Method for selecting Cell in table, adds it to selectFoods list
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FoodCardCell {
            cell.isBlue = true
            foodDictionary[indexPath.section].list[indexPath.row].isSelected = true
            if let food = cell.food {
                selectedFoods.append(food)
                toggleEatButton?(true)
            }
            
        }
    }
    
    // Method for deselecting Cell in table
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FoodCardCell {
            
            // Set the cell to be not selected, store the selected value within the food list as well
            cell.isBlue = false
            foodDictionary[indexPath.section].list[indexPath.row].isSelected = false
            
            // Find the index of the food by the name
            let foodIndex = selectedFoods.index(where: { cell.food?.name == $0.name })
            // Only remove at index if index is not nil
            if (foodIndex != nil) {
                selectedFoods.remove(at: foodIndex!)
            }
            
            if (selectedFoods.count == 0) {
                toggleEatButton?(false)
            }
            
        }
    }
}
