//
//  FirstViewController
//  ColCu 
//  Created by Roma on 13/02/2016.
//  Copyright © 2016 Victor J Demmetran. All rights reserved.
//
//  ** 1.HOME SCREEN **
 
import UIKit
import Foundation

class FirstViewController: UIViewController {
    
    @IBOutlet var xchangeRateResultLabel: UILabel!
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var globe1: UIImageView!
    
//---------------------------------------------------------------------
    @IBAction func refreshXchangeRateButton(sender: AnyObject) {
        
        downLoadData()
    }
    
//---------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        downLoadData()
        
        // ** AutoRrefresh - Per 1 hour
        NSTimer.scheduledTimerWithTimeInterval(3600.0, target: self, selector: #selector(FirstViewController.refreshXchangeRateButton(_:)), userInfo: nil, repeats: true)
     }
//---------------------------------------------------------------------
    
    // ** Func to D/Load data + check-ifInternetAndAlert **
    func downLoadData() {
    
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.color = UIColor.blackColor() // Actual Indic.Color
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.layer.cornerRadius = 10

        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        let url = NSURL(string: "https://www.google.co.uk/finance?q=GBPCOP")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent!.componentsSeparatedByString("1 GBP = <span class=bld>")
                
                if websiteArray.count > 0 {
                    
                    let secondArray = websiteArray[1].componentsSeparatedByString(" COP</span>")
                    
                    if secondArray.count > 0 {
                        
                        let xchangeRateString = secondArray[0]
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            //** Remove "," and "." from string-Int
                            let newXchangeRateString = xchangeRateString.stringByReplacingOccurrencesOfString(",", withString: "") // worked=removed ","
                            
                            let xchangeRateNumber = Double(newXchangeRateString)!
                            
                            NSUserDefaults.standardUserDefaults().setDouble(xchangeRateNumber, forKey: "xchangeRateNumber")
                            NSUserDefaults.standardUserDefaults().synchronize() // force saving
                            
                            let formatter = NSNumberFormatter()
                            formatter.numberStyle = .CurrencyStyle
                            formatter.locale = NSLocale(localeIdentifier: "en_US") // look like $COP pesos
                            
                            let formattedNumber = formatter.stringFromNumber(xchangeRateNumber)
                            
                            self.xchangeRateResultLabel.text = "£1 = \(formattedNumber!) COP"
                        })
                    }
                }
            } else {
            }
        }
        task.resume()
        
        // Stop User interaction while Alert PopUp Code=running / stop warning from Apple
        self.view.userInteractionEnabled = false
        self.tabBarController?.tabBar.userInteractionEnabled = false
        
        // ** 2-3 seconds to Download data and save in NSUserDefaults
        // Thus Wait 4 seconds and call - the IfAlert func // DOES NOT REPEAT (false)
        NSTimer.scheduledTimerWithTimeInterval(04.0, target: self, selector: #selector(FirstViewController.ifInternetAndAlert), userInfo: nil, repeats: false)
    }
    
// ** > 4 secs check if label = updated with new info
    func ifInternetAndAlert() {
        
        activityIndicator.stopAnimating()
        
        // ReEnable User Interaction
        self.view.userInteractionEnabled = true
        self.tabBarController?.tabBar.userInteractionEnabled = true
        
        if xchangeRateResultLabel.text! == "... rate ..." {
            internetAlertPopUp()
            
        } else {
            callIfAlert()
        }
     }

    func internetAlertPopUp() {
        
        let alertInternet = UIAlertController(title: "Internet Alert", message: "Check you are connected to the internet and Press Refresh!", preferredStyle: .Alert)
        
        let cancelAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            uialertaction in
            alertInternet.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertInternet.addAction(cancelAction1)
        
        self.presentViewController(alertInternet, animated: true, completion: nil)
        
        // ** 15 secs delay and dismiss alert
        let delay = 15.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alertInternet.dismissViewControllerAnimated(true, completion: nil) // alertInternet = Var for UIAlertController
        })
    }
    
// ** 'IF' Alert condition=met?
    func callIfAlert() {
        
        NSUserDefaults.standardUserDefaults().integerForKey("xchangeRateNumber")
        let storedNumber = NSUserDefaults.standardUserDefaults().integerForKey("xchangeRateNumber")
        
        NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        let newCopAlertValue = NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        
        if storedNumber >= newCopAlertValue {
            
            callLocalNotification()
            alertPopUp()
        }
    }
    
    func alertPopUp() {
        
        NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        let newCopAlertValue = NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US") // look like $COP pesos
        
        let formattedNumber = formatter.stringFromNumber(newCopAlertValue)
        
        let alert = UIAlertController(title: "COP value alert", message: "COP is above \(formattedNumber!)", preferredStyle: .Alert) //  capital A for .Alert
        
        // ** CANCEL BUTTON
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        // ** Now Add these Actions to the Alert
        alert.addAction(cancelAction)
        
        // ** tell Alert to PopUp
        self.presentViewController(alert, animated: true, completion: nil)
        
        // ** 15 secs delay and dismiss alert
        let delay = 15.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alert.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func callLocalNotification() {
    
        NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        let newCopAlertValue = NSUserDefaults.standardUserDefaults().integerForKey("numberFromTextField")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US") // look like $COP pesos
        
        let formattedNumber = formatter.stringFromNumber(newCopAlertValue)
        
        let localNotification = UILocalNotification()
        
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5) // 5 second from now
        localNotification.alertBody = "COP is above \(formattedNumber!)"
        localNotification.alertAction = "Check Out COP"
        localNotification.soundName = UILocalNotificationDefaultSoundName // No sound = default
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        // localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}








