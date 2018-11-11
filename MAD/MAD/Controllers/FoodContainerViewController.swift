//
//  FoodContainerViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

public class FoodContainerViewController : UIViewController {
    
    @IBOutlet weak var eatButton: UIButton!
    private var childTable : FoodListViewController!
    private var navBar: CustomNavigationBar!
    
    public override func viewDidAppear(_ animated: Bool) {
        toggleEatButton(on: false)
        // Get the child view of the Embeded View, which should be our table
//        if let embededView = childViewControllers[0] as? FoodListViewController {
//            childTable = embededView
//            childTable.setToggleEatButton(method: {on in self.toggleEatButton(on: on) })
//        }
    }
    
    @IBAction func onEatClicked(_ sender: UIButton) {
        // Unwrap selectedFoods list in if let statment, and then consume all the food
        if let foodEaten = childTable.selectedFoods {
            for i in 0..<foodEaten.count {
                UserSettings.instance.consume(food: foodEaten[i])
            }
        }
        performSegue(withIdentifier: "unwindToMainSegue", sender: sender)
    }
    
    @IBAction func onBackClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMainSegue", sender: sender)
    }
    
    private func toggleEatButton(on: Bool) {
        eatButton?.isEnabled = on
        eatButton?.setTitleColor(on ? UIColor.white : UIColor(red: 25, green: 25, blue: 25, alpha: 0.8), for: .normal) 
    }
    
}
