//
//  PickerViewPickerPopUp.swift
//  
//
//  Created by Yung Dai on 2015-06-15.
//
//

import UIKit

class PickerViewPickerPopUp: NSObject, UIPopoverPresentationControllerDelegate, PickerViewControllerDelegate {
   
    typealias PickerViewPickerPopUpCallBack = (newText : String, forTextField: UITextField) -> ()
    
    var pickerViewVC : PickerViewController
    var popover : UIPopoverPresentationController?
    var textField : UITextField!
    var dataChanged : PickerViewPickerPopUpCallBack?
    var presented = false
    var offset : CGFloat = 8.0
    
    internal init(forTextField: UITextField) {
        pickerViewVC = PickerViewController()
        self.textField = forTextField
        super.init()
    }
    
    // popup picker call back function
    
    func pick(inViewController : UIViewController, initString : String?, dataChanged : PickerViewPickerPopUpCallBack) {
        
        if presented {
            return
        }
        
        pickerViewVC.delegate = self
        pickerViewVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        pickerViewVC.preferredContentSize = CGSizeMake(500, 208)
//        pickerViewVC.selectedText = initString
        
        popover = pickerViewVC.popoverPresentationController
        
        if let popped = popover {
            popped.sourceView = textField
            popped.sourceRect = CGRectMake(self.offset, textField.bounds.size.height, 0, 0)
            popped.delegate = self
            self.dataChanged = dataChanged
            inViewController.presentViewController(pickerViewVC, animated: true, completion: nil)
            presented = true
        }
        
        
    }
    
    // We are telling to the popover presentation controller that the presentation must be not adaptive at all and so it uses the popover also on the iPhone.
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    func pickerVCDismissed(text: String?) {
        if let datachanged = dataChanged {
            if let  text = text {
                datachanged(newText: text, forTextField: textField)
            }
        }
        presented = false
    }
    
}
