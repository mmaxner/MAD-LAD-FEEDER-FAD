//
//  FoodDetailTableController.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-12.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

public class FoodDetailTableController: UITableViewController {
    
    @IBOutlet weak var caloriesTxtField: UITextField!
    @IBOutlet weak var carbsTxtField: UITextField!
    @IBOutlet weak var proteinTxtField: UITextField!
    @IBOutlet weak var fatTxtField: UITextField!
    
    public var food : Food!
    public var editable: Bool! {
        didSet {
            caloriesTxtField?.resignFirstResponder()
            carbsTxtField?.resignFirstResponder()
            proteinTxtField?.resignFirstResponder()
            fatTxtField?.resignFirstResponder()
            setLayout()
        }
    }
    
    public var macros: NutritionalFacts {
        var macros = NutritionalFacts()
        macros.totalCalories = caloriesTxtField?.text?.number ?? 0
        macros.totalCarbs = carbsTxtField?.text?.number ?? 0
        macros.totalProtein = proteinTxtField?.text?.number ?? 0
        macros.totalFat = fatTxtField?.text?.number ?? 0
        
        return macros
    }
    
    public override func viewDidLoad() {
        // Add done buttons to keyboards, since number-pads do not have their own
        caloriesTxtField.addDoneButtonOnKeyboard()
        carbsTxtField.addDoneButtonOnKeyboard()
        proteinTxtField.addDoneButtonOnKeyboard()
        fatTxtField.addDoneButtonOnKeyboard()
        
        setLayout()
        
        // Set delegates to this controller
        caloriesTxtField.delegate = self
        carbsTxtField.delegate = self
        proteinTxtField.delegate = self
        fatTxtField.delegate = self
        
        // Footer, stops from showing multiple empty cells
        tableView.tableFooterView = UIView()
    }
    
    public func setLayout() {
        if let calories = food?.calorieBreakdown {
            caloriesTxtField?.text = "\(calories.totalCalories.internationalize!)"
            carbsTxtField?.text = "\(calories.totalCarbs.internationalize!)"
            proteinTxtField?.text = "\(calories.totalProtein.internationalize!)"
            fatTxtField?.text = "\(calories.totalFat.internationalize!)"
        }
        else {
            caloriesTxtField?.text = nil
            carbsTxtField?.text = nil
            proteinTxtField?.text = nil
            fatTxtField?.text = nil
        }
        
//        if editable {
//            caloriesTxtField?.text = caloriesTxtField.text?.cleanNumberFormat
//            carbsTxtField?.text = carbsTxtField.text?.cleanNumberFormat
//            proteinTxtField?.text = proteinTxtField.text?.cleanNumberFormat
//            fatTxtField?.text = fatTxtField?.text?.cleanNumberFormat
//        }
    }
    
    public func validate() -> Bool {
        return !(caloriesTxtField.text?.isEmpty ?? true) && !(carbsTxtField.text?.isEmpty ?? true)
            && !(proteinTxtField.text?.isEmpty ?? true) && !(fatTxtField.text?.isEmpty ?? true)
    }
}

extension FoodDetailTableController : UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return editable ?? false
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        
        return text.count < 8 && string.range(of: "^[0-9]*$", options: .regularExpression) != nil
    }
}
