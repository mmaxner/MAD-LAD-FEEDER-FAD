//
//  FoodListViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Not Conner Henry. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController, UITableViewDataSource  {
    let sections = ["fruit", "vegetals", "very bad"];
    let fruits = ["banana", "orang", "tomato"];
    let vegetals = ["cucumber", "brocoli", "carrot"];
    let very_bad = ["steak", "burger", "hotdog"];
    
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
            return vegetals.count;
        case 2:
            return very_bad.count;
        default:
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath);
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = fruits[indexPath.row];
        case 1:
            cell.textLabel?.text = vegetals[indexPath.row];
        case 2:
            cell.textLabel?.text = very_bad[indexPath.row];
        default:
            break;
        }
        return cell;
    }
    
}
