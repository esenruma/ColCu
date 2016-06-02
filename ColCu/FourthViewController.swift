//
//  FourthViewController.swift
//  ColCu
//  Created by Roma on 13/02/2016.
//  Copyright © 2016 Victor J Demmetran. All rights reserved.
//
// *** 4. BUYS ***

import UIKit

class FourthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableViewItems: UITableView!
    @IBOutlet var tableViewCOPValues: UITableView!
    @IBOutlet var tableViewGBPValues: UITableView!

    let itemsList = ["DRINKS", "Coffee", "Local Beer", "Water", "Red Wine bot.", "MEALS", "Breakfast", "Lunch", "Dinner", "Miscel", "Newspaper", "Cinema Ticket", "Gym p.m."]
    
    let copValueList = ["", "3,000", "2,500", "3,000", "36,000", "", "10,000", "15,000", "15,000", "", "1,700", "15,000", "100,000"]
    
    let bgColors : [UIColor] = [UIColor(red: 252/255, green: 209/255, blue: 22/255, alpha: 1.0), UIColor.clearColor(), UIColor.clearColor(), UIColor.clearColor(), UIColor.clearColor(), UIColor(red: 252/255, green: 209/255, blue: 22/255, alpha: 1.0), UIColor.clearColor(), UIColor.clearColor(), UIColor.clearColor(), UIColor(red: 252/255, green: 209/255, blue: 22/255, alpha: 1.0), UIColor.clearColor(), UIColor.clearColor(), UIColor.clearColor()]
    
        // UIColor.redColor(), UIColor.blueColor()]
    
// ------------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 13
    }
// ------------------------------------------------------------------------
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        // cell.backgroundColor = UIColor.clearColor() // clear TAbleView Colour
        cell.backgroundColor = self.bgColors[indexPath.row]
        
        // ------------------------------------------
        NSUserDefaults.standardUserDefaults().integerForKey("xchangeRateNumber")
        let storedNumber = NSUserDefaults.standardUserDefaults().integerForKey("xchangeRateNumber")
        
        let newStoredNumber = Double(storedNumber)
        
        let coffee = 3000.00 / newStoredNumber
            let coffeeN = String(format: "%.2f", coffee)
        
        let localBeer = 2500.00 / newStoredNumber
            let localBeerN = String(format: "%.2f", localBeer)
        
        let water = 3000.00 / newStoredNumber
            let waterN = String(format: "%.2f", water)
        
        let redWine = 36000.00 / newStoredNumber
            let redWineN = String(format: "%.2f", redWine)
        
        let breakfast = 10000.00 / newStoredNumber
            let breakfastN = String(format: "%.2f", breakfast)
        
        let lunch = 15000.00 / newStoredNumber
            let lunchN = String(format: "%.2f", lunch)
        
        let dinner = 15000.00 / newStoredNumber
            let dinnerN = String(format: "%.2f", dinner)
        
        let newspaper = 1700.00 / newStoredNumber
            let newspaperN = String(format: "%.2f", newspaper)
        
        let cinema = 15000.00 / newStoredNumber
            let cinemaN = String(format: "%.2f", cinema)
        
        let gym = 100000.00 / newStoredNumber
        let gymN = String(format: "%.2f", gym)
        
        let gbpList = ["", "\(coffeeN)", "\(localBeerN)", "\(waterN)", "\(redWineN)", "", "\(breakfastN)", "\(lunchN)", "\(dinnerN)", "", "\(newspaperN)", "\(cinemaN)", "\(gymN)"]
        // ------------------------------------------
        
        if (tableView == self.tableViewItems) {
            
            cell.textLabel!.font = UIFont.systemFontOfSize(14.0) // FONT SIZE
            cell.textLabel!.textAlignment = .Left                // ALIGNMENT
            cell.textLabel!.text = self.itemsList[indexPath.row]
                return cell
            
        } else if (tableView == self.tableViewCOPValues) {
            
            cell.textLabel!.font = UIFont.systemFontOfSize(9.0) // FONT SIZE
            cell.textLabel!.textAlignment = .Right
            cell.textLabel!.text = self.copValueList[indexPath.row]
                return cell
        
        } else {
            cell.textLabel!.font = UIFont.boldSystemFontOfSize(15)  // FONT SIZE / Bold
            cell.textLabel!.textColor = UIColor(red: 0/255, green: 56/255, blue: 147/255, alpha: 1.0) // BLUE FONT COLOR
            cell.textLabel!.textAlignment = .Right
            cell.textLabel!.text = gbpList[indexPath.row]
                return cell
        }
    }
// ------------------------------------------------------------------------
    // ** refresh table to "UN-HIGHLIGHT" any row selected previously + refresh page
    override func viewDidAppear(animated: Bool) {
        
        self.tableViewItems.reloadData()
        self.tableViewCOPValues.reloadData()
        self.tableViewGBPValues.reloadData()
    }    
// ------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableViewItems.dataSource = self
        self.tableViewItems.delegate = self
        
        self.tableViewCOPValues.dataSource = self
        self.tableViewCOPValues.delegate = self
        
        self.tableViewGBPValues.dataSource = self
        self.tableViewGBPValues.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

