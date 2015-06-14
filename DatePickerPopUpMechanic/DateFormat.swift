//
//  DateFormat.swift
//  DatePickerPopUpMechanic
//
//  Created by Yung Dai on 2015-06-12.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit


// create an extension for NSDate function for the medium string style for the date and short style for time
extension NSDate {
    
    // -> Date System Formatted Medium
    func ToDateMediumString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle;
        formatter.timeStyle = .ShortStyle;
        return formatter.stringFromDate(self)
    }
}