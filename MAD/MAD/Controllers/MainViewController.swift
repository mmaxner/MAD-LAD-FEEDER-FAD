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
    // User's name
    @IBOutlet weak var nameLbl: UILabel!
    // Macro level UILabels
    @IBOutlet weak var carbsLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var fatLbl: UILabel!
    
    @IBOutlet weak var macroStackView: UIStackView!
    
    override func loadView() {
        super.loadView()
        
//        calorieProgress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addFood)))
        nameLbl.alpha = 0.0
        macroStackView.alpha = 0.0
        calorieProgress.calorieLbl.alpha = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the user's calories, macros, and name
        loadProgressBar()
        loadMacroValues()
        nameLbl.text = "Welcome"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Fade in the text
        UIView.animate(withDuration: Constants.FadeInTime, animations: {
            self.macroStackView.alpha = 1.0
            self.nameLbl.alpha = 1.0
            self.calorieProgress.calorieLbl.alpha = 1.0
        }, completion: { finished in
            self.nameLbl.fadeTo(text: UserSettings.instance.name, for: CGFloat(Constants.FadeInTime * 2))
        })
    }
    
    // Loads the Calorie Progress bar, setting the ratio of calories and displays the current calorie amount
    private func loadProgressBar() {
        let calories = UserSettings.instance.calorieBreakdown.totalCalories
        calorieProgress.setProgress(calories: calories, maxCalories: UserSettings.instance.maxCalories)
    }
    
    // Loads the User's total Carb, Protein, and Fat consumed
    private func loadMacroValues() {
        carbsLbl.text = "\(UserSettings.instance.calorieBreakdown.totalCarbs)g"
        proteinLbl.text = "\(UserSettings.instance.calorieBreakdown.totalProtein)g"
        fatLbl.text = "\(UserSettings.instance.calorieBreakdown.totalFat)g"
    }
    
    @objc public func addFood() {
        let food = Food(name: "burger!", calories: 100, protein: 30, fat: 2, carbs: 40)
        UserSettings.instance.consume(food: food)
        loadProgressBar()
        loadMacroValues()
    }

}

