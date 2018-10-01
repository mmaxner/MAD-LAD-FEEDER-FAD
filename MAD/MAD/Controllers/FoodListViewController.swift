//
//  FoodListViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Not Conner Henry. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController, UITableViewDataSource  {
    let sections = ["Fruit", "Vegetables", "Nuts"];
    let fruits = [
        Food(name: "banana", calories: 5, protein: 50, fat: 0, carbs: 2),
        Food(name: "orange", calories: 7, protein: 12, fat: 1000, carbs: 20),
        Food(name: "apple", calories: 6, protein: 6, fat: 6, carbs: 6)
    ];
    let vegetables = [
        Food(name: "cucumber", calories: 5, protein: 50, fat: 0, carbs: 2),
        Food(name: "carrot", calories: 7, protein: 12, fat: 1000, carbs: 20),
        Food(name: "peas", calories: 6, protein: 6, fat: 6, carbs: 6)
    ];
    let nuts = [
        Food(name: "almond", calories: 5, protein: 50, fat: 0, carbs: 2),
        Food(name: "cashew", calories: 7, protein: 12, fat: 1000, carbs: 20),
        Food(name: "DEEZ", calories: 6, protein: 6, fat: 6, carbs: 6)
    ];
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section];
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return fruits.count;
        case 1:
            return vegetables.count;
        case 2:
            return nuts.count;
        default:
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath);
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = fruits[indexPath.row].name;
        case 1:
            cell.textLabel?.text = vegetables[indexPath.row].name;
        case 2:
            cell.textLabel?.text = nuts[indexPath.row].name;
        default:
            break;
        }
        return cell;
    }
    
}
