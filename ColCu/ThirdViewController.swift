//
//  ThirdViewController.swift
//  ColCu
//  Created by Roma on 13/02/2016.
//  Copyright © 2016 Victor J Demmetran. All rights reserved.

//  ** 3.SHOPS LIST **

import UIKit

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var shopsTableView: UITableView!
    
    var shopList = ["Inara Transfers Ltd", "Ria Money Transfers", "Post Office", "Money Corp", "ATMs in Colombia"]
    
    // make a variable of who the user selected...
    // set this up 1st to work in -- prepareForSegue FUNC below
    var selectedName = "Inara"
    
    // ** Globe Animations **
    @IBOutlet weak var globe_1: UIImageView!
    @IBOutlet weak var globe_2: UIImageView!
    @IBOutlet weak var globe_3: UIImageView!
    @IBOutlet weak var globe_4: UIImageView!
    @IBOutlet weak var globe_5: UIImageView!
// ----------------------------------------------------------------------
    override func viewDidLayoutSubviews() {
        
        self.globe_1.center = CGPointMake(self.globe_1.center.x + 600, self.globe_1.center.y)
        self.globe_2.center = CGPointMake(self.globe_2.center.x - 600, self.globe_2.center.y)
        self.globe_3.center = CGPointMake(self.globe_3.center.x + 600, self.globe_3.center.y)
        self.globe_4.center = CGPointMake(self.globe_4.center.x - 600, self.globe_4.center.y)
        self.globe_5.center = CGPointMake(self.globe_5.center.x + 600, self.globe_5.center.y)
    }
    
    override func viewDidAppear(animated: Bool) {
        // ** refresh table to "UN-HIGHLIGHT" any row selected previously
        self.shopsTableView.reloadData()
        
        // ** Globe Animats **
        UIView.animateWithDuration(0.5) {
            self.globe_1.center = CGPointMake(self.globe_1.center.x - 600, self.globe_1.center.y)
            self.globe_2.center = CGPointMake(self.globe_2.center.x + 600, self.globe_2.center.y)
            self.globe_3.center = CGPointMake(self.globe_3.center.x - 600, self.globe_3.center.y)
            self.globe_4.center = CGPointMake(self.globe_4.center.x + 600, self.globe_4.center.y)
            self.globe_5.center = CGPointMake(self.globe_5.center.x - 600, self.globe_5.center.y)
        }
    }

// ----------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel!.text = shopList[indexPath.row]
        return cell
    }
// ----------------------------------------------------------------------
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedName = shopList[indexPath.row]
        self.performSegueWithIdentifier("thirdToDetail", sender: self)
    }
// ----------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailsVC = segue.destinationViewController as! ThirdDetailedViewController
        
        detailsVC.name = self.selectedName
        
        switch self.selectedName {
            case "Inara Transfers Ltd":
                detailsVC.address = "Unit 241, Elephant & Castle Shopping Centre, London\n" + "SE1 6TE"
                detailsVC.webAddress = "www.inara.co.uk"
                detailsVC.telephone = "0207 252 5949"
                detailsVC.email = "info@inara.com"
                detailsVC.miscel = " * £ to COP: Yes, but call first.\n" + " * COP to £: Yes.\n" + " * Has International calling telephone booths.\n"
            
                detailsVC.image = UIImage(named: "Inara_Shop")
            
            case "Ria Money Transfers":
                detailsVC.address = "Unit 211, Elephant & Castle Shopping Centre, London\n" + "SE1 6TE"
                detailsVC.webAddress = "www.riafinancial.com"
                detailsVC.telephone = "0207 740 6942"
                detailsVC.email = "via website"
                detailsVC.miscel = " * £ to COP: Yes.\n" + " * COP to £: Yes.\n" + " * Has Internet cafe.\n"
            
                detailsVC.image = UIImage(named: "Ria shop photo")

            case "Post Office":
                detailsVC.address = "Lots of branches all over London"
                detailsVC.webAddress = "www.postoffice.co.uk"
                detailsVC.telephone = "0345 611 2970"
                detailsVC.email = "not available"
                detailsVC.miscel = " * Telephone number above to find local branches.\n" + " * Also see www.postoffice.co.uk/branch-finder.\n"
            
                detailsVC.image = UIImage(named: "PO shop_3")

            case "Money Corp":
                detailsVC.address = "11 central London locations"
                detailsVC.webAddress = "www.moneycorp.com/uk/"
                detailsVC.telephone = "0330 010 1050"
                detailsVC.email = "tmqueries@moneycorp.com"
                detailsVC.miscel = " * Home delivery of COP available.\n" + " * Online reviews vary from shop to shop.\n"
            
                detailsVC.image = UIImage(named: "money corp shop")
            
            case "ATMs in Colombia":
                detailsVC.address = "Your own card company"
                detailsVC.webAddress = "General Advice Website"
                detailsVC.telephone = "Your own card company"
                detailsVC.email = "not available"
                detailsVC.miscel = " * This also avoids risk of getting counterfit cash from local vendors.\n"
            
                detailsVC.image = UIImage(named: "ATMs_Colombia")
            
            default:
                print("No Other Options")
        } // End Switch
        
    }
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
    // ** make cells of tableView = TRANPARENT to show image at Back
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = .clearColor()
        cell.textLabel!.textAlignment = .Center
    }
// ----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.shopsTableView.dataSource = self
        self.shopsTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

