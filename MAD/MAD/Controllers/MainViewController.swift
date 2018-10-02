//
//  ViewController.swift
//  MAD
//
//  Created by Conner Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // Custom CircleProgressBar for the daily calorie amount
    @IBOutlet weak var calorieProgress: CalorieProgressBar!
    // MARK: User's name
    @IBOutlet weak var nameLbl: UILabel!
    // MARK: Macro level UILabels
    @IBOutlet weak var carbsLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var fatLbl: UILabel!
    
    @IBOutlet weak var macroStackView: UIStackView!
    // MARK: Buttons
    @IBOutlet weak var forkButton: UIButton!
    @IBOutlet weak var gearButton: UIButton!
    
    override func loadView() {
        super.loadView()
        nameLbl.alpha = 0.0
        macroStackView.alpha = 0.0
        calorieProgress.calorieLbl.alpha = 0.0
        
        // Load the user's calories, macros, and name
        loadProgressBar()
        loadMacroValues()
        nameLbl.text = "Welcome"
        
        forkButton.applyTintToImage(tint: UIColor.white)
        gearButton.applyTintToImage(tint: UIColor.white)
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

    // MARK: - IBActions for Controls
    
    // IBAction for clicking the forkButton. Sends the user to the food list view
    @IBAction func onForkClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "foodListSegue", sender: sender)
    }
    
    // IBAction for clicking the gearButton. Sends the user to the settings view
    @IBAction func onSettingsClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "settingsSegue", sender: sender)
    }
}

