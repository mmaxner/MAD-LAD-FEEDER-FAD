//
//  ViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var calorieProgress: CircleProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let calories = UserSettings.instance.calorieBreakdown.totalCalories
        calorieProgress.progress = CGFloat(calories / UserSettings.instance.maxCalories)
        calorieProgress.set(calories: calories)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

