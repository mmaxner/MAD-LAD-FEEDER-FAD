//
//  SettingsViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-01.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblCalories: UILabel!
    @IBOutlet weak var sldCalories: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = UserSettings.instance.name
        sldCalories.value = Float(UserSettings.instance.maxCalories)
        lblCalories.text = "\(UserSettings.instance.maxCalories)"
    }
    
    @IBAction func onSaveClicked(_ sender: UIButton) {
        UserSettings.instance.name = txtName.text!
        UserSettings.instance.maxCalories = Int(sldCalories.value)
        performSegue(withIdentifier: "unwindToMainSegue", sender: sender)
    }
    
    @IBAction func sldCalories_ValueChanged(_ sender: UISlider) {
        lblCalories.text = "\(Int(sldCalories.value))"
    }
    
    @IBAction func onBackClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMainSegue", sender: sender)
    }
    
}
