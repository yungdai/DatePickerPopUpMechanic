//
//  ViewController.swift
//  DatePickerPopUpMechanic
//
//  Created by Yung Dai on 2015-06-12.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var datePickerPopUp : DatePickerPopUp?

    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerPopUp = DatePickerPopUp(forTextField: dateOfBirthTextField)
        dateOfBirthTextField.delegate = self

    }
    
    func resign() {
        dateOfBirthTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField === dateOfBirthTextField) {
         resign()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            let initDate : NSDate? = dateFormatter.dateFromString(dateOfBirthTextField.text)
            
            let dataChangeCallBack : DatePickerPopUp.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField)->() in
                
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
            
            }
            
            datePickerPopUp!.pick(self, initDate: initDate, dataChanged: dataChangeCallBack)
            return false
        } else {
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        var msg : String
        if nameTextField.text != "" && dateOfBirthTextField.text != "" {
            msg = nameTextField.text + " " + dateOfBirthTextField.text
        } else {
            msg = "Name or Date empty!"
        }
        let alert:UIAlertController = UIAlertController(title: title, message: msg, preferredStyle:.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        self.presentViewController(alert, animated:true, completion:nil);
        
        
    }

}
