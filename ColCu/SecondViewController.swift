//
//  SecondViewController.swift
//  ColCu
//  Created by Roma on 13/02/2016.
//  Copyright © 2016 Victor J Demmetran. All rights reserved.

//  ** 2.CONVERTER SCREEN **
 
import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var inputGBPAmount: UITextField!
    
    @IBOutlet var inputCOPAmount: UITextField!
    
    @IBOutlet var emergencyMessageTextField: UILabel!
    
    @IBOutlet var resultsLabel: UILabel!
    
    // ** Animat Lines **
    @IBOutlet weak var blueLine1: UIImageView!
    @IBOutlet weak var blueLine2: UIImageView!
    
    
// ---------Animation for Lines ------------
    override func viewDidLayoutSubviews() {
        self.blueLine1.center = CGPointMake(self.blueLine1.center.x, self.blueLine1.center.y - 200)
        self.blueLine2.center = CGPointMake(self.blueLine2.center.x, self.blueLine2.center.y + 800)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1.0) { 
            self.blueLine1.center = CGPointMake(self.blueLine1.center.x, self.blueLine1.center.y + 200)
        self.blueLine2.center = CGPointMake(self.blueLine2.center.x, self.blueLine2.center.y - 800)
        }
    }
    
// -------------------------------------------------------------------------
    @IBAction func ConvertButton(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().doubleForKey("xchangeRateNumber")
        let storedNumber = NSUserDefaults.standardUserDefaults().doubleForKey("xchangeRateNumber")
        
        if inputGBPAmount.text!.isEmpty && inputCOPAmount.text!.isEmpty  {
            
            self.emergencyMessageTextField.hidden = false
            self.emergencyMessageTextField.text! = "Please enter an amount you want converted!!!"
            
            NSTimer.scheduledTimerWithTimeInterval(03.0, target: self, selector: #selector(SecondViewController.deleteEmergencyMessage), userInfo: nil, repeats: false)
            
        } else if inputGBPAmount.text! != "" {
            
            var inputGBPNumber = Double(inputGBPAmount.text!)
            
            let newGBnumber = Double(inputGBPAmount.text!) // keep original number for Results Label
            
            inputGBPNumber = inputGBPNumber! * storedNumber
            
            // ** No. format to show in resultLabel...
            let formatter1 = NSNumberFormatter()
            formatter1.numberStyle = .CurrencyStyle
            formatter1.locale = NSLocale(localeIdentifier: "en_GB")
            let formattedNumber1 = formatter1.stringFromNumber(newGBnumber!)
            
            let formatter2 = NSNumberFormatter()
            formatter2.numberStyle = .CurrencyStyle
            formatter2.locale = NSLocale(localeIdentifier: "en_US") // look like $COP pesos
            let formattedNumber2 = formatter2.stringFromNumber(inputGBPNumber!)
            
            resultsLabel.text! = "\(formattedNumber1!)  =  \(formattedNumber2!) COP"
            
            inputGBPAmount.text! = ""
            emergencyMessageTextField.text! = ""
            
        } else if inputCOPAmount.text! != "" {
            
            var inputCOPNumber = Double(inputCOPAmount.text!)
            
            let newCOPnumber = Double(inputCOPAmount.text!) // keep original number for Results Label
            
            inputCOPNumber = inputCOPNumber! / storedNumber
            
            // ** No. format to show in resultLabel...
            let formatter1 = NSNumberFormatter()
            formatter1.numberStyle = .CurrencyStyle
            formatter1.locale = NSLocale(localeIdentifier: "en_US")
            let formattedNumber1 = formatter1.stringFromNumber(newCOPnumber!)
            
            let formatter2 = NSNumberFormatter()
            formatter2.numberStyle = .CurrencyStyle
            formatter2.locale = NSLocale(localeIdentifier: "en_GB")
            let formattedNumber2 = formatter2.stringFromNumber(inputCOPNumber!)
            
            resultsLabel.text! = "\(formattedNumber1!) COP  =  \(formattedNumber2!)"
            
            inputCOPAmount.text! = ""
            emergencyMessageTextField.text! = ""
         }
        
        self.view.endEditing(true)  // Close KeyPad
     }
    
    func deleteEmergencyMessage() {
        // delete message after 4 seconds NSTimer
        
        self.emergencyMessageTextField.hidden = true // Hide Label Again
        self.emergencyMessageTextField.text! = ""
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        
        self.inputGBPAmount.text! = ""
        self.inputCOPAmount.text! = ""
        self.emergencyMessageTextField.text! = ""
        self.emergencyMessageTextField.hidden = true  // Hide Label Again
        self.resultsLabel.text! = ""
        
        self.view.endEditing(true) // Close KeyPad
     }

// -----------------------------KEYBOARD BEHAVIOUR---------------------------------
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        inputGBPAmount.resignFirstResponder()
        inputCOPAmount.resignFirstResponder()
        return true
    }
    
// -------------------------------------------------------------------------
    override func viewWillAppear(animated: Bool) {
        self.emergencyMessageTextField.hidden = true  // Hide Label Again
    }
    
// -------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ** Control UITextField
        self.inputGBPAmount.delegate = self
        //self.inputGBPAmount.keyboardType = .NumberPad
        
        self.inputCOPAmount.delegate = self
        //self.inputCOPAmount.keyboardType = .NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

