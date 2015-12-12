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

var foodname = [String]()
var serves = [String]()
var expiry = [NSDate]()
var foodstatus = [String]()
var imageFiles = [PFFile]()
var posteduser = [String]()
var phonenumber = [String]()
var fdescription = [String]()
var foodType = [String]()
var pAddress = [String]()
var pCity = [String]()
var pState = [String]()
var postedAt = [NSDate]()

var currentIndex = 0


class FoodRequestTableViewController: UITableViewController {

    
    @IBAction func mapButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("mapSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var currentIndex = 0
        
        var foodRequestSummaryQuery = PFQuery(className: "Request")
        
        foodRequestSummaryQuery.whereKey("userid", notEqualTo: PFUser.currentUser()!.objectId!)
        
        foodRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects, ErrorType) -> Void in
            
            foodname.removeAll(keepCapacity: true)
            serves.removeAll(keepCapacity: true)
            expiry.removeAll(keepCapacity: true)
            foodstatus.removeAll(keepCapacity: true)
            imageFiles.removeAll(keepCapacity: true)
            posteduser.removeAll(keepCapacity: true)
            fdescription.removeAll(keepCapacity: true)
            foodType.removeAll(keepCapacity: true)
            pAddress.removeAll(keepCapacity: true)
            pCity.removeAll(keepCapacity: true)
            pState.removeAll(keepCapacity: true)
            phonenumber.removeAll(keepCapacity: true)
            postedAt.removeAll(keepCapacity: true)
            
            
            
            if let objects = objects {
                
                for object in objects {
                    
                    
                    foodname.append(object["foodname"]! as! String)
                    serves.append(object["serves"]! as! String)
                    expiry.append(object["expiry"]! as! NSDate)
                    imageFiles.append(object["image"] as! PFFile)
                    alllatitude.append(object["pickuplatitude"] as! CLLocationDegrees)
                    alllongitude.append(object["pickuplongitude"] as! CLLocationDegrees)
                    foodstatus.append(object["status"] as! String)
                    posteduser.append(object["contactname"] as! String)
                    fdescription.append(object["fooddescription"] as! String)
                   // foodType.append(<#T##newElement: String##String#>)
                    pAddress.append(object["pickupaddress"] as! String)
                    pCity.append(object["pickupcity"] as! String)
                    pState.append(object["pickupstate"] as! String)
                    phonenumber.append(object["contactphone"] as! String)
                    postedAt.append(object.createdAt! as! NSDate)
                    
                    
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
        
        print(indexPath.row)
        print(foodstatus[indexPath.row])
        foodcell.foodName.text = foodname[indexPath.row]
        foodcell.servesLabel.text = "Serves " + String(serves[indexPath.row])
        foodcell.statusLabel.text = foodstatus[indexPath.row]
        foodcell.descriptionLabel.text = fdescription[indexPath.row]
        foodcell.postedByUser.text = "Posted by : " + String(posteduser[indexPath.row])
    
        
        
        // Posted Time
        let pcalendar = NSCalendar.currentCalendar()
        let pcomponents = pcalendar.components([.Day, .Hour, .Minute, .Second], fromDate: postedAt[indexPath.row], toDate: NSDate(), options: [])


        
        var pdaytext = ""
        var phourtext = ""
        
        if pcomponents.day == 1{
            pdaytext = " day ago "
        }else {
            pdaytext = " days ago "
        }
        
        if pcomponents.hour == 1 {
            phourtext = " hour ago "
        }else{
            phourtext = " hours ago "
        }
        
        if pcomponents.day > 0 {
            foodcell.postedWhen.text = String(pcomponents.day) + pdaytext
        } else {
            foodcell.postedWhen.text = String(pcomponents.hour) + phourtext
        }

        
        // Remaining Time
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
            foodcell.expiryLabel.text = String(components.day) + daytext + String(components.hour) + " Hours remaining"
        } else {
            foodcell.expiryLabel.text = String(components.hour) + hourtext + String(components.minute) +
            " Mins remaining"
        }
        
        return foodcell
    }
    
    
    override func viewDidAppear(animated: Bool) {
        var foodRequestSummaryQuery = PFQuery(className: "Request")
        
        foodRequestSummaryQuery.whereKey("userid", notEqualTo: PFUser.currentUser()!.objectId!)
      //  foodRequestSummaryQuery.whereKey("pickupcity", equalTo: String("Bloomington"))
        
        
        foodRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects, ErrorType) -> Void in
            
            foodname.removeAll(keepCapacity: true)
            serves.removeAll(keepCapacity: true)
            expiry.removeAll(keepCapacity: true)
            foodstatus.removeAll(keepCapacity: true)
            imageFiles.removeAll(keepCapacity: true)
            posteduser.removeAll(keepCapacity: true)
            fdescription.removeAll(keepCapacity: true)
            foodType.removeAll(keepCapacity: true)
            pAddress.removeAll(keepCapacity: true)
            pCity.removeAll(keepCapacity: true)
            pState.removeAll(keepCapacity: true)
            phonenumber.removeAll(keepCapacity: true)
            postedAt.removeAll(keepCapacity: true)
            
            
            
            if let objects = objects {
                
                for object in objects {
                    
                    
                    foodname.append(object["foodname"]! as! String)
                    serves.append(object["serves"]! as! String)
                    expiry.append(object["expiry"]! as! NSDate)
                    imageFiles.append(object["image"] as! PFFile)
                    alllatitude.append(object["pickuplatitude"] as! CLLocationDegrees)
                    alllongitude.append(object["pickuplongitude"] as! CLLocationDegrees)
                    foodstatus.append(object["status"] as! String)
                    posteduser.append(object["contactname"] as! String)
                    fdescription.append(object["fooddescription"] as! String)
                    // foodType.append(<#T##newElement: String##String#>)
                    pAddress.append(object["pickupaddress"] as! String)
                    pCity.append(object["pickupcity"] as! String)
                    pState.append(object["pickupstate"] as! String)
                    phonenumber.append(object["contactphone"] as! String)
                    postedAt.append(object.createdAt! as! NSDate)
                    
                    
                    self.tableView.reloadData()
                    
                  
                }
            }
            
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("foodDetailSegue", sender: self)
        currentIndex = indexPath.row
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
