//
//  FoodListViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Not Conner Henry. All rights reserved.
//

import UIKit

class FoodListViewController: UITableViewController  {
    let sections = ["Fruit", "Vegetables", "Nuts"];
    let fruits = [
        Food(name: "Banana", calories: 50, protein: 0, fat: 2, carbs: 13),
        
        Food(name: "Orange", calories: 70, protein: 12, fat: 3, carbs: 15),
        Food(name: "Apple", calories: 20, protein: 1, fat: 0, carbs: 12)
    ];
    let vegetables = [
        Food(name: "Cucumber", calories: 5, protein: 0, fat: 0, carbs: 2),
        Food(name: "Carrot", calories: 30, protein: 12, fat: 1000, carbs: 5),
        Food(name: "Peas", calories: 6, protein: 2, fat: 0, carbs: 4)
    ];
    let nuts = [
        Food(name: "Almonds", calories: 250, protein: 50, fat: 0, carbs: 2),
        Food(name: "Cashews", calories: 400, protein: 12, fat: 15, carbs: 20)
    ];
    
    override func loadView() {
        super.loadView()
        tableView.register(UINib(nibName: "FoodCardView", bundle: nil), forCellReuseIdentifier: "FoodCardView")
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return fruits.count
        case 1:
            return vegetables.count
        case 2:
            return nuts.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCardView", for: indexPath) as? FoodCardCell {
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            cell.backgroundView = nil
            switch (indexPath.section) {
            case 0:
                cell.food = fruits[indexPath.row]
            case 1:
                cell.food = vegetables[indexPath.row]
            case 2:
                cell.food = nuts[indexPath.row]
            default:
                break;
            }
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
}
