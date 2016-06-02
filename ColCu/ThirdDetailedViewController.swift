//
//  ThirdDetailedViewController.swift
//  ColCu 
//  Created by Roma on 14/02/2016.
//  Copyright © 2016 Victor J Demmetran. All rights reserved.
//
//  ** 3A.SHOPS **

import UIKit

class ThirdDetailedViewController: UIViewController {

     
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var webSite: UILabel!
    @IBOutlet var telephoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var miscelNotesLabel: UILabel!
    @IBOutlet var imageViewThirdDetailVC: UIImageView!
    
    // create properties for labels
    var name = "Inara"
    var address = "Elephant & Castle"
    var webAddress = "info@inara.com"
    var telephone = "0207 554 6723"
    var email = "info@inara.co.uk"
    var miscel = "Notes"
    var image = UIImage(named: "inara_Logo")
    
// -----------------------------------------------------------
// click to email...
    
    @IBAction func sendEmail(sender: AnyObject) {
        
        if self.name == "Inara Transfers Ltd" {
            
            let emailInara = "info@inara.co.uk"
            let url4 = NSURL(string: "mailto:\(emailInara)")
            UIApplication.sharedApplication().openURL(url4!)
            
        } else if self.name == "Ria Money Transfers" {
            
            // ** no direct email - ONLINE form only
            let url4 = NSURL(string: "http://www.riafinancial.com/global/contact-us.aspx")
            UIApplication.sharedApplication().openURL(url4!)
            
            
        } else if self.name == "Post Office" {
            
            // No email - do nothing
            
        } else if self.name == "Money Corp" {
            
            let emailMoneyCorp = "tmqueries@moneycorp.com"
            let url4 = NSURL(string: "mailto:\(emailMoneyCorp)")
            UIApplication.sharedApplication().openURL(url4!)
            
        } else if self.name == "ATMs in Colombia" {
            
            // No email - do nothing
            
        }
     }
    
// click to Telephone call...
    
    @IBAction func telephoneCall(sender: AnyObject) {
        if self.name == "Inara Transfers Ltd" {
            
            let url3 = NSURL(string: "tel://02072525949")
            UIApplication.sharedApplication().openURL(url3!)
            
        } else if self.name == "Ria Money Transfers" {
            
            let url3 = NSURL(string: "tel://02077406942")
            UIApplication.sharedApplication().openURL(url3!)
            
        } else if self.name == "Post Office" {
            
            let url3 = NSURL(string: "tel://03456112970")
            UIApplication.sharedApplication().openURL(url3!)
            
        } else if self.name == "Money Corp" {
            
            let url3 = NSURL(string: "tel://03300101050")
            UIApplication.sharedApplication().openURL(url3!)
            
        } else if self.name == "ATMs in Colombia" {
            
            // ** Do Nothing for ATMs
        }
    }
    
// click to website...  // NB: button invisible over 'webSite: UILabel!'
    @IBAction func toWebsite(sender: AnyObject) {
        
        if self.name == "Inara Transfers Ltd" {
            let url2 = NSURL(string: "http://www.inara.co.uk/index.html")
            UIApplication.sharedApplication().openURL(url2!)
            
        } else if self.name == "Ria Money Transfers" {
            let url2 = NSURL(string: "http://www.riafinancial.com/locations/UK/home.aspx")
            UIApplication.sharedApplication().openURL(url2!)
            
        } else if self.name == "Post Office" {
            let url2 = NSURL(string: "http://www.postoffice.co.uk/foreign-currency")
            UIApplication.sharedApplication().openURL(url2!)
            
        } else if self.name == "Money Corp" {
            let url2 = NSURL(string: "https://www.moneycorp.com/uk/travel-money/")
            UIApplication.sharedApplication().openURL(url2!)
            
        } else if self.name == "ATMs in Colombia" {
            let url2 = NSURL(string: "http://www.medellinliving.com/colombian-currency-counterfeits-exchanging-money/")
            UIApplication.sharedApplication().openURL(url2!)
        }
    }

// click to google maps... // NB: button invisible over 'addressLabel'
    @IBAction func addressLink(sender: AnyObject) {
        

        
        
        if self.name == "Inara Transfers Ltd" {
            let url1 = NSURL(string: "https://www.google.co.uk/maps/place/Inara+Transfers+Ltd/@51.4944784,-0.1000348,15z/data=!4m2!3m1!1s0x0:0xd14db554ab56847f")
            UIApplication.sharedApplication().openURL(url1!)
            
        } else if self.name == "Ria Money Transfers" {
            let url1 = NSURL(string: "https://www.google.co.uk/maps/place/Ria+Money+Transfer+-+Elephant+%26+Castle/@51.493981,-0.1018166,17z/data=!3m1!4b1!4m2!3m1!1s0x487604a2031708b3:0x821ca17f2726828")
            UIApplication.sharedApplication().openURL(url1!)
            
        } else if self.name == "Post Office" {
            let url1 = NSURL(string: "http://www.postoffice.co.uk/branch-finder")
            UIApplication.sharedApplication().openURL(url1!)
                        
        } else if self.name == "Money Corp" {
            let url1 = NSURL(string: "https://www.moneycorp.com/uk/travel-money/find-a-branch/central-london/")
            UIApplication.sharedApplication().openURL(url1!)
            
        } else if self.name == "ATMs in Colombia" {
            
            // ** Do Nothing for ATMs
        }
    }

// -----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.nameLabel.text = self.name
        self.addressLabel.text = self.address
        self.webSite.text = self.webAddress
        self.telephoneLabel.text = self.telephone
        self.emailLabel.text = self.email
        self.miscelNotesLabel.text = self.miscel
        self.imageViewThirdDetailVC.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



