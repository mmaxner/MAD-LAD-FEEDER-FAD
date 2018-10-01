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
        txtName.text = Settings.instance.name
        sldCalories.value = Settings.instance.calories
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save_Click(_ sender: UIButton) {
        Settings.instance.name = txtName.text!
        Settings.instance.calories = sldCalories.value
    }
    
    @IBAction func sldCalories_ValueChanged(_ sender: UISlider) {
        lblCalories.text = sldCalories.description
    }
    
}
