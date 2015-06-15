//
//  PickerViewController.swift
//  
//
//  Created by Yung Dai on 2015-06-15.
//
//

import UIKit

// create a deleate for the PickerViewController

protocol PickerViewControllerDelegate : class {
    func pickerVCDismissed(text : String?)

}


class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var container: UIView!
    @IBOutlet weak var textPicker: UIPickerView!
    
//    var selectedActivity = String()
    
    
    
    let activities = ["Watch TV", "Go For Drinks", "Play Sports", "Watch a Movie", "Go To An Event"]
    
    weak var delegate: PickerViewControllerDelegate?
    
    var selectedText : String? {
        didSet {
            updatePickerCurrentText()
        }
    }
    
    func updatePickerCurrentText() {
        if let selectedText = self.selectedText {
            if let textPicker = self.textPicker {
                var selectedRow = self.textPicker.selectedRowInComponent(0)
                var activityString = self.activities[selectedRow]
                self.delegate?.pickerVCDismissed(activityString)
            }
        }
    }
    
    convenience init() {
        self.init(nibName: "PickerViewPickerPopUp", bundle: nil)
    }
    
    
    @IBAction func okAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {
            var selectedRow = self.textPicker.selectedRowInComponent(0)
            var activityString = self.activities[selectedRow]
            self.delegate?.pickerVCDismissed(activityString)
        }
        
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        updatePickerCurrentText()
//    }

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return activities[row]
    }
}
