//
//  FoodContainerViewController.swift
//  MAD
//
//  Created by Connor Henry on 2018-10-02.
//  Copyright © 2018 Conner Henry. All rights reserved.
//

import UIKit

public class FoodContainerViewController : UIViewController {
    
    private var navBar: CustomNavigationBar!
    @IBOutlet weak var eatBtn: UIBarButtonItem!
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectItemsStk: UIStackView!
    @IBOutlet weak var selectedItemsLbl: UILabel!
    
    public private(set) var isSelecting: Bool = false
    
    public private(set) var selectedFoods: [Food]! {
        didSet {
            let numberFormat = NumberFormatter()
            numberFormat.numberStyle = .none
            selectedItemsLbl.text = selectedFoods.count.internationalize
        }
    }
    
    private enum TranslatedText: String {
        case Select = "Select"
        case Cancel = "Cancel"
        
        public var string: String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
    
    // Set the sections of Food available, which is a list of names (String) and an array of Foods
    var foodDictionary: [Food]!
    
    public override func viewDidLoad() {
        toggleEatButton(on: false)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(UINib(nibName: "FoodCardView", bundle: nil), forCellWithReuseIdentifier: "FoodCardView")
        
        selectItemsStk.alpha = 0.0
        selectedFoods = [Food]()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foodDictionary = UserSettings.instance.foodList
        collectionView?.reloadData()
    }
    
    @IBAction func onEatClicked(_ sender: Any) {
        // Unwrap selectedFoods list in if let statment, and then consume all the food
        for i in 0..<selectedFoods.count {
            UserSettings.instance.consume(food: selectedFoods[i])
        }
        performSegue(withIdentifier: "unwindToMain", sender: sender)
    }

    @IBAction func onAddClicked(_ sender: Any) {
        performSegue(withIdentifier: "foodDetailSegue", sender: nil)
    }
    
    // Action for selectBtn Click, switches the view between selected mode and non selected mode
    @IBAction func onSelectClicked(_ sender: Any) {
        isSelecting = !isSelecting
        
        selectBtn.title = isSelecting ? TranslatedText.Cancel.string : TranslatedText.Select.string
        
        // Toggle 'Items Selected: 0' stack view
        UIView.animate(withDuration: 0.25, animations: {
            self.selectItemsStk.alpha = self.isSelecting ? 1.0 : 0.0
        })
        
        // Toggle back button
        self.navigationItem.setHidesBackButton(isSelecting, animated: true)
        
        if !isSelecting {
            clearSelection()
        }
        
        collectionView?.allowsMultipleSelection = isSelecting
    }
    
    private func toggleEatButton(on: Bool) {
        eatBtn?.isEnabled = on
        eatBtn?.tintColor = on ? UIColor.white : UIColor(red: 25, green: 25, blue: 25, alpha: 1.0)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check if the destination is the FoodDetailController, and if the sender is the food assigned to the clicked cell
        if let foodDetail = segue.destination as? FoodDetailController {
            if let food = sender as? Food {
                foodDetail.food = food
                foodDetail.editable = false
            }
            else {
                foodDetail.editable = true
            }
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
    @IBAction func unwindToFoodListController(segue:UIStoryboardSegue) {
        
    }
}

extension FoodContainerViewController: UICollectionViewDelegate {
    
    // Deselect all food cards if cancelling selection
    public func clearSelection() {
        for index in 0 ..< selectedFoods.count {
            let indexPath = IndexPath(row: index, section: 0)
            collectionView(collectionView!, didDeselectItemAt: indexPath)
        }
        selectedFoods.removeAll()
    }
    
    // Method for deselecting Cell in table
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FoodCardCell {
            
            // Set the cell to be not selected, store the selected value within the food list as well
            cell.isBlue = false
            foodDictionary[indexPath.row].isSelected = false
            
            // Find the index of the food by the name
            let foodIndex = selectedFoods.index(where: { cell.food?.name == $0.name })
            // Only remove at index if index is not nil
            if (foodIndex != nil) {
                selectedFoods.remove(at: foodIndex!)
            }
            
            if (selectedFoods.count == 0) {
                toggleEatButton(on: false)
            }
            
        }
    }
    
    // Method for selecting Cell in table, adds it to selectFoods list
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FoodCardCell {
            // If selecting, highlight card as blue and start counting it
            if isSelecting {
                cell.isBlue = true
                foodDictionary[indexPath.row].isSelected = true
                if let food = cell.food {
                    selectedFoods.append(food)
                    toggleEatButton(on: true)
                }
            }
            // Otherwise take the user to the detail view
            else {
                performSegue(withIdentifier: "foodDetailSegue", sender: cell.food)
            }
        }
    }
}

extension  FoodContainerViewController : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodDictionary.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCardView", for: indexPath) as? FoodCardCell {
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            cell.food = foodDictionary[indexPath.row]
            // Make sure cell is highlighted when recreating it
            cell.isBlue = selectedFoods.index(where: { cell.food?.name == $0.name }) != nil
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
}
