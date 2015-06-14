//
//  DatePickerViewController.swift
//  DatePickerPopUpMechanic
//
//  Created by Yung Dai on 2015-06-12.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit


// create a delegate for the DatePickerrViewontroller
protocol DatePickerViewControllerDelgate : class {
    
    func datePickerVCDismissed(date : NSDate?)
}


class DatePickerViewController: UIViewController {

    @IBOutlet var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    weak var delegate: DatePickerViewControllerDelgate?
    
    var currentDate : NSDate? {
        didSet {
            updatePickerCurrentDate()
        }
    }
    
    
    // initialise the DatePickerPopUp View
    convenience init() {
        self.init(nibName: "DatePickerPopUp", bundle: nil)
    }
    
    
    
    func updatePickerCurrentDate() {
        
        if let currentDate = self.currentDate {
            if let datePicker = self.datePicker {
                datePicker.date = currentDate
            }
        }
    }
    
    // when you press the oken button
    @IBAction func okAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) {
            
            let nsdate = self.datePicker.date
            self.delegate?.datePickerVCDismissed(nsdate)
            
        }
    }
    
    override func viewDidLoad() {
        
        updatePickerCurrentDate()
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        self.delegate?.datePickerVCDismissed(nil)
    }
}
