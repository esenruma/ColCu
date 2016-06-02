//
//  FifthViewController.swift
//  ColCu 
//  Created by Roma on 13/02/2016.
//  Copyright © 2016 Victor J Demmetran. All rights reserved.

// *** 5. SET UP ALERTS ***
 
import UIKit

class FifthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var copInputTextField: UITextField!
    
    @IBOutlet var resultsLabel: UILabel!
    
    @IBOutlet var existingAlert: UILabel!
    
    let copAlertNumber = NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
    
// --------------------------------------------------------------------------------
    @IBAction func alertSavedButton(sender: AnyObject) {
        
        if copInputTextField.text!.isEmpty {
            self.resultsLabel.textColor = UIColor.redColor()
            self.resultsLabel.text = "Please enter a number!!!"
            
            NSTimer.scheduledTimerWithTimeInterval(03.0, target: self, selector: #selector(FifthViewController.clearResultsLabel), userInfo: nil, repeats: false)
            
        } else {
        
        let numberFromTextField = Int(copInputTextField.text!)
        
        //** Save this number to NSUserDefaults to use in other VCs
        //** "setInteger" i.e. a number NOT Object or String
        NSUserDefaults.standardUserDefaults().setInteger(numberFromTextField!, forKey: "numberFromTextField")
        NSUserDefaults.standardUserDefaults().synchronize() // force the saving of data
        
        // get the stored no.
        let copAlertNumber = NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        
        // Number Format Int into a String with "," and "."
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale(localeIdentifier: "en_US")  // look like $COP pesos
            
            let formattedNumber = formatter.stringFromNumber(copAlertNumber)
        
        self.resultsLabel.textColor = UIColor.blueColor()
        self.resultsLabel.text = "NEW Alert value has been saved as... \n \(formattedNumber!) COP"
        
        copInputTextField.text = ""
        }
        
        self.view.endEditing(true) // close phonePad when Save Button=pressed
    }
    
    func clearResultsLabel() {
        // used with NSTimer
        resultsLabel.text! = ""
    }
    
// --------------------------------------------------------------------------------
// Keyboard Behaviour
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
// --------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.copInputTextField.delegate = self
        self.copInputTextField.keyboardType = .NumberPad
        
        // Number Format Int into a String with "," and "."
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US") // look like $COP pesos
        
        let formattedNumber = formatter.stringFromNumber(copAlertNumber)
        
        // Note prev.alert value (formatted)
        self.existingAlert.text = "PREVIOUS Alert Value was...\n \(formattedNumber!) COP"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

