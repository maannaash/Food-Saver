//
//  MyRequestTableViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MyRequestTableViewController: UITableViewController {

    
    var foodname = [String]()
    var serves = [String]()
    var expiry = [NSDate]()
    var status = [String]()
    var imageFiles = [PFFile]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var myRequestSummaryQuery = PFQuery(className: "Request")
        myRequestSummaryQuery.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
        
        myRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects , error ) -> Void in
            
            self.foodname.removeAll(keepCapacity: true)
            self.serves.removeAll(keepCapacity: true)
            self.expiry.removeAll(keepCapacity: true)
            self.status.removeAll(keepCapacity: true)
            self.imageFiles.removeAll(keepCapacity: true)
            
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
        let mycell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! Cell

        // Configure the cell...
        
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data , error ) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                mycell.postedImage.image = downloadedImage
            }
        }
        
        
        mycell.foodName.text = foodname[indexPath.row]
        mycell.servesLabel.text = serves[indexPath.row]
       // mycell.expiryLabel.text = String(expiry[indexPath.row])
        
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: expiry[indexPath.row], options: [])
        
        var daytext = ""
        var hourtext = ""
        
        if components.day == 1{
            daytext = " Day & "
        }else {
            daytext = " Days & "
        }
        
        if components.hour == 1 {
            hourtext = " Hour & "
        }else{
            hourtext = " Hours & "
        }
        
        
        if components.day > 0 {
            mycell.expiryLabel.text = String(components.day) + daytext + String(components.hour) + " Hours remaining"
        } else {
            mycell.expiryLabel.text = String(components.hour) + hourtext + String(components.minute) +
            " Minutes remaining"
        }

        

        return mycell
    }

    override func viewDidAppear(animated: Bool) {
        var myRequestSummaryQuery = PFQuery(className: "Request")
        myRequestSummaryQuery.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
        
        myRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects , error ) -> Void in
            
            self.foodname.removeAll(keepCapacity: true)
            self.serves.removeAll(keepCapacity: true)
            self.expiry.removeAll(keepCapacity: true)
            self.status.removeAll(keepCapacity: true)
            self.imageFiles.removeAll(keepCapacity: true)
            
            if let objects = objects {
                
                for object in objects {
                    
                    self.foodname.append(object["foodname"]! as! String)
                    self.serves.append(object["serves"]! as! String)
                    self.expiry.append(object["expiry"]! as! NSDate)
                    self.imageFiles.append(object["image"] as! PFFile)
                    
                    self.tableView.reloadData()
                    
                    print(object)
                }
            }
            
        }
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
