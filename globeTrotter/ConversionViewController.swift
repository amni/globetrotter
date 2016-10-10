//
//  ConversionViewController.swift
//  globeTrotter
//
//  Created by Alan Ni on 10/9/16.
//  Copyright © 2016 Alan Ni. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var farenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double?{
        if let value = farenheitValue {
            return (value-32)*(5/9)
        }
        else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField:UITextField,shouldChangeCharactersInRange range:NSRange, replacementString string:String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparate = string.rangeOfString(".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparate != nil {
            return false
        }
        else if let text = string.rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet()){
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func farenheitFieldEditingChanged(textField:UITextField) {
        if let text = textField.text, value = Double(text){
            farenheitValue = value
        }
        else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard (sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    let numberFormatter:NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
}
