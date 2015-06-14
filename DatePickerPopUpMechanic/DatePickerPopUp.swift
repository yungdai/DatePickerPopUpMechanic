//
//  DatePickerPopUp.swift
//  DatePickerPopUpMechanic
//
//  Created by Yung Dai on 2015-06-12.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class DatePickerPopUp: NSObject, UIPopoverPresentationControllerDelegate, DatePickerViewControllerDelgate {
    
    typealias DatePickerPopUpCallBack = (newDate : NSDate, forTextField : UITextField)->()
    
    var datePickerVC : DatePickerViewController
    var popover : UIPopoverPresentationController?
    var textField : UITextField!
    var dataChanged : DatePickerPopUpCallBack?
    var presented = false
    var offset : CGFloat = 8.0
    
    internal init(forTextField: UITextField) {
        
        datePickerVC = DatePickerViewController()
        self.textField = forTextField
        super.init()
    }
    
    // popup picker callback function
    func pick(inViewController : UIViewController, initDate : NSDate?, dataChanged : DatePickerPopUpCallBack) {
        
        if presented {
            return  // we are busy
        }
        
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        datePickerVC.preferredContentSize = CGSizeMake(500,208)
        datePickerVC.currentDate = initDate
        
        popover = datePickerVC.popoverPresentationController
        if let popped = popover {
            
            popped.sourceView = textField
            popped.sourceRect = CGRectMake(self.offset,textField.bounds.size.height,0,0)
            popped.delegate = self
            self.dataChanged = dataChanged
            inViewController.presentViewController(datePickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    func datePickerVCDismissed(date : NSDate?) {
        
        if let dataChanged = dataChanged {
            
            if let date = date {
                
                dataChanged(newDate: date, forTextField: textField)
                
            }
        }
        presented = false
    }

}
