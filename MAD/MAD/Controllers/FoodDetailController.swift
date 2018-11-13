//
//  FoodDetailController.swift
//  MAD
//
//  Created by Conner Henry on 2018-11-12.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

public class FoodDetailController: UIViewController {
    
    @IBOutlet weak var foodNameTxtField: UITextField!
    @IBOutlet weak var descTxtView: UITextView!
    @IBOutlet weak var foodImgView: UIImageView!
    @IBOutlet weak var chooseImageCard: RoundedCardView!
    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    private var saveBarBtn: UIBarButtonItem!
    private var childVC: FoodDetailTableController!
    
    public var food: Food!
    public var editable: Bool! {
        didSet {
            if let editable = editable, let descTxtView = descTxtView {
                descTxtView.isEditable = editable
            }
        }
    }
    
    private var descriptionInDefault: Bool = false
    
    fileprivate enum TranslatedText: String {
        case DescriptionPlaceholder = "Enter description..."
        case FoodPlaceholder = "Enter Food Name..."
        case Cancel = "Cancel"
        case Edit = "Edit"
        case AlertName = "Form not complete"
        case AlertMessage = "Some information on this form has not been complete, and cannot save."
        case Ok = "Ok"
        case Save = "Save"
        case NewFood = "New Food"
        
        public var string: String {
            return NSLocalizedString(rawValue, comment: "")
        }
    }
    
    public override func viewDidLoad() {
        setLayout()
        
        // Set if the controls are editable or not
        descTxtView.isEditable = editable
        descTxtView.delegate = self
        foodNameTxtField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage(_:)))
        tapGesture.numberOfTapsRequired = 1
        
        // Make the food image view editable and add a tap gesture to it
        foodImgView.isUserInteractionEnabled = true
        foodImgView.addGestureRecognizer(tapGesture)
        
        // Create save bar button in closure...
        saveBarBtn = {
            let saveBtn = UIButton(type: .system)
            let font = saveBtn.titleLabel?.font
            saveBtn.setTitle(TranslatedText.Save.string, for: .normal)
            saveBtn.setTitle(TranslatedText.Save.string, for: .focused)
            // Resize font to 17, to match 'Edit/Cancel' button
            saveBtn.titleLabel?.font = UIFont(name: font?.fontName ?? "", size: 17)
            saveBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            saveBtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
            
            let barBtn = UIBarButtonItem()
            barBtn.customView = saveBtn
            return barBtn
        }()
        
        // Update layout to show the edit state
        showEditState()
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // In Container Controller, a segue is preformed when the child ViewController is embeded
        // Here we are grabbing that vc, the Food Detail TableController, and passing it information, while storing it as a class level property
        if let childVC = segue.destination as? FoodDetailTableController {
            self.childVC = childVC
            self.childVC.food = food
            self.childVC.editable = editable
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
    @objc public func chooseImage(_ target: Any?) {
        // If editable, show image picker when clicking on the image
        if editable {
            let picker = UIImagePickerController()
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = false
            picker.delegate = self
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    // Sets the layout of the view to show either the food values, or empty if there is no food
    public func setLayout() {
        // Set food info if it exists,
        if let food = food {
            foodNameTxtField.text = food.name
            descTxtView.text = food.description
            foodImgView.image = food.image
            titleItem?.title = food.name
        }
        // Otherwise set info to nil and set title to say 'New Food'
        else {
            foodNameTxtField.text = nil
            descTxtView.text = TranslatedText.DescriptionPlaceholder.string
            descriptionInDefault = true
            titleItem?.title = TranslatedText.NewFood.string
        }
        
        childVC?.setLayout()
    }
    
    @IBAction func onEditClick(_ sender: Any) {
        editable = !editable
        showEditState()
    }
    
    private func showEditState() {
        // Toggle edit button title
        editBtn?.title = editable ? TranslatedText.Cancel.string : TranslatedText.Edit.string
        
        // Toggle back button
        self.navigationItem.setHidesBackButton(editable, animated: true)
        
        // Cancelling...
        if !editable {
            // If not editable and has no food item, then this was an add screen, and it should perform an unwind segue
            if food == nil {
                performSegue(withIdentifier: "unwindToFoodList", sender: self)
            }
            else {
                setLayout()
            }
            self.navigationItem.leftBarButtonItem = nil
            
            // Resign first responders when cancelling the edit
            foodNameTxtField.resignFirstResponder()
            descTxtView.resignFirstResponder()
        }
        // Editing...
        else {
            // Bring up keyboard on food name, to show that the page is now editable
            foodNameTxtField.becomeFirstResponder()
            self.navigationItem.leftBarButtonItem = self.saveBarBtn
        }
        
        // Update the child view controller to the same editable state
        childVC?.editable = editable
    }
    
    // Method for saving the food item (Adding or updating)
    @objc public func save() {
        if !validate() {
            let alert = UIAlertController(title: TranslatedText.AlertName.string,
                                          message: TranslatedText.AlertMessage.string,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: TranslatedText.Ok.string, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // Add new item
            if food == nil {
                let newFood = Food(name: foodNameTxtField.text!, image: foodImgView.image!, description: descTxtView.text!, macros: childVC.macros)
                UserSettings.instance.foodList.append(newFood)
            }
            // Update item
            else {
                food.name = foodNameTxtField.text
                food.image = foodImgView.image
                food.description = descTxtView.text
                food.calorieBreakdown = childVC.macros
            }
            
            onEditClick(self)
        }
    }
    
    // Method to validate the form
    public func validate() -> Bool {
        let macrosValid = childVC?.validate() ?? false
        let nameValid = !(foodNameTxtField.text?.isEmpty ?? true)
        let descValid = !(descTxtView?.text?.isEmpty ?? true) && !descriptionInDefault
        let imageValid = foodImgView?.image != nil
        return macrosValid && nameValid && descValid && imageValid
    }
}

extension FoodDetailController: UITextFieldDelegate {
    // Determines whether the text fields can't be edited
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return editable
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension FoodDetailController: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionInDefault {
            textView.text = ""
            descriptionInDefault = false
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        // Check if the textView is empty on finishing edit...
        if textView.text?.isEmpty ?? false {
            // If so, show the default placeholder text
            textView.text = TranslatedText.DescriptionPlaceholder.string
            descriptionInDefault = true
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Close keyboard if user hits return key, which is displayed as 'Done'
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}

// Delegate for ImagePicker Controller, helps pass back image when selected and allows for other methods to handle controller actions
extension FoodDetailController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        foodImgView.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

