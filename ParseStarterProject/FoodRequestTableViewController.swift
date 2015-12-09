//
//  FoodRequestTableViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var alllatitude = [CLLocationDegrees]()
var alllongitude = [CLLocationDegrees]()

class FoodRequestTableViewController: UITableViewController {

    var foodname = [String]()
    var serves = [String]()
    var expiry = [NSDate]()
    var foodstatus = [String]()
    var imageFiles = [PFFile]()

    
    @IBAction func mapButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("mapSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var foodRequestSummaryQuery = PFQuery(className: "Request")
        
        foodRequestSummaryQuery.whereKey("userid", notEqualTo: PFUser.currentUser()!.objectId!)
        
        foodRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects, ErrorType) -> Void in
            
            self.foodname.removeAll(keepCapacity: true)
            self.serves.removeAll(keepCapacity: true)
            self.expiry.removeAll(keepCapacity: true)
            self.imageFiles.removeAll(keepCapacity: true)
            self.foodstatus.removeAll(keepCapacity: true)
            
            if let objects = objects {
                
                for object in objects {
                    
                    self.foodname.append(object["foodname"]! as! String)
                    self.serves.append(object["serves"]! as! String)
                    self.expiry.append(object["expiry"]! as! NSDate)
                    self.imageFiles.append(object["image"] as! PFFile)
                    alllatitude.append(object["pickuplatitude"] as! CLLocationDegrees)
                    alllongitude.append(object["pickuplongitude"] as! CLLocationDegrees)
                    self.foodstatus.append(object["status"] as! String)
                    
                    self.tableView.reloadData()
                    
                    
                }
            }

        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodname.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let foodcell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodCell

        // Configure the cell...
        
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data , error ) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                foodcell.postedImage.image = downloadedImage
            }
        }
        
        foodcell.foodName.text = foodname[indexPath.row]
        foodcell.servesLabel.text = serves[indexPath.row]
        foodcell.expiryLabel.text = String(expiry[indexPath.row])
        //foodcell.statusLabel.text = foodstatus[indexPath.row]
        
        return foodcell
    }
    
    
    override func viewDidAppear(animated: Bool) {
        var foodRequestSummaryQuery = PFQuery(className: "Request")
        
        foodRequestSummaryQuery.whereKey("userid", notEqualTo: PFUser.currentUser()!.objectId!)
      //  foodRequestSummaryQuery.whereKey("pickupcity", equalTo: String("Bloomington"))
        
        
        foodRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects, ErrorType) -> Void in
            
            self.foodname.removeAll(keepCapacity: true)
            self.serves.removeAll(keepCapacity: true)
            self.expiry.removeAll(keepCapacity: true)
            self.imageFiles.removeAll(keepCapacity: true)
            self.foodstatus.removeAll(keepCapacity: true)
            
            if let objects = objects {
                
                for object in objects {
                    
                    self.foodname.append(object["foodname"]! as! String)
                    self.serves.append(object["serves"]! as! String)
                    self.expiry.append(object["expiry"]! as! NSDate)
                    self.imageFiles.append(object["image"] as! PFFile)
                    
                    self.tableView.reloadData()
                    
                  
                }
            }
            
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("foodDetailSegue", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
