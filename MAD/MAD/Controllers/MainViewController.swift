//
//  ViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // Custom CircleProgressBar for the daily calorie amount
    @IBOutlet weak var calorieProgress: CalorieProgressBar!
    // Macro level UILabels
    @IBOutlet weak var carbsLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var fatLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadProgressBar()
    }
    
    // Loads the Calorie Progress bar, setting the ratio of calories and displays the current calorie amount
    private func loadProgressBar() {
        let calories = UserSettings.instance.calorieBreakdown.totalCalories
        calorieProgress.progress = CGFloat(calories / UserSettings.instance.maxCalories)
        calorieProgress.set(calories: calories)
    }
    
    // Loads the User's total Carb, Protein, and Fat consumed
    private func loadMacroValues() {
        carbsLbl.text = "\(UserSettings.instance.calorieBreakdown.totalCarbs)g"
        proteinLbl.text = "\(UserSettings.instance.calorieBreakdown.totalProtein)g"
        fatLbl.text = "\(UserSettings.instance.calorieBreakdown.totalFat)g"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

