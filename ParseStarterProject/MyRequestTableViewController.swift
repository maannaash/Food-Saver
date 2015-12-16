//
//  MyRequestTableViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var myfoodname = [String]()
var myserves = [String]()
var myexpiry = [NSDate]()
var mystatus = [String]()
var myimageFiles = [PFFile]()
var myposteduser = [String]()
var myphonenumber = [String]()
var myfdescription = [String]()
var myfoodType = [String]()
var mypAddress = [String]()
var mypCity = [String]()
var mypState = [String]()
var mypostedAt = [NSDate]()
var mypostObjectIds = [String]()

var mycurrentIndex = 0


class MyRequestTableViewController: UITableViewController {

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100),
            NSFontAttributeName : UIFont(name: "Futura", size: 20)!
        ]
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, width, height))
        imgView.image = UIImage(named: "fbg1.png")!
        imgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imgView)
        self.view.sendSubviewToBack(imgView)
        
        var myRequestSummaryQuery = PFQuery(className: "Request")
        myRequestSummaryQuery.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
        
        myRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects , error ) -> Void in
            
            myfoodname.removeAll(keepCapacity: true)
            myserves.removeAll(keepCapacity: true)
            myexpiry.removeAll(keepCapacity: true)
            mystatus.removeAll(keepCapacity: true)
            myimageFiles.removeAll(keepCapacity: true)
            myposteduser.removeAll(keepCapacity: true)
            myfdescription.removeAll(keepCapacity: true)
            myfoodType.removeAll(keepCapacity: true)
            mypAddress.removeAll(keepCapacity: true)
            mypCity.removeAll(keepCapacity: true)
            mypState.removeAll(keepCapacity: true)
            myphonenumber.removeAll(keepCapacity: true)
            mypostedAt.removeAll(keepCapacity: true)
            mypostObjectIds.removeAll(keepCapacity: true)
            
            if let objects = objects {
                
                for object in objects {
                    
                    myfoodname.append(object["foodname"]! as! String)
                    myserves.append(object["serves"]! as! String)
                    myexpiry.append(object["expiry"]! as! NSDate)
                    myimageFiles.append(object["image"] as! PFFile)
                    mystatus.append(object["status"] as! String)
                    myposteduser.append(object["contactname"] as! String)
                    myfdescription.append(object["fooddescription"] as! String)
                    //myfoodType.append(<#T##newElement: String##String#>)
                    mypAddress.append(object["pickupaddress"] as! String)
                    mypCity.append(object["pickupcity"] as! String)
                    mypState.append(object["pickupstate"] as! String)
                    myphonenumber.append(object["contactphone"] as! String)
                    mypostedAt.append(object.createdAt! as! NSDate)
                    mypostObjectIds.append(object.objectId!)
                    
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
        return myfoodname.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mycell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! Cell

        // Configure the cell...
        
        
        myimageFiles[indexPath.row].getDataInBackgroundWithBlock { (data , error ) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                mycell.postedImage.image = downloadedImage
            }
        }
        
        var tpimageView = UIImageView(frame: CGRectMake(10, 10, mycell.frame.width - 10, mycell.frame.height - 10))
        

        
        if mystatus[indexPath.row] == "Available" {
            
            tpimageView = UIImageView(image: UIImage(named: "lgc.png"))
            mycell.backgroundView = tpimageView
            mycell.myStatusImage.image = UIImage(named: "bgc.png")
            
        }else {
            if mystatus[indexPath.row] == "Blocked"{
                
                tpimageView = UIImageView(image: UIImage(named: "loc.png"))
                mycell.backgroundView = tpimageView
                mycell.myStatusImage.image = UIImage(named: "doc.png")
                
                
            }else {
                tpimageView = UIImageView(image: UIImage(named: "lrc.png"))
                mycell.backgroundView = tpimageView
                mycell.myStatusImage.image = UIImage(named: "brc.png")
            }
        }
        

        
        
        mycell.foodName.text = myfoodname[indexPath.row]
        mycell.servesLabel.text = "Serves " + myserves[indexPath.row]
        mycell.statusLabel.text = String(mystatus[indexPath.row])
        
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: myexpiry[indexPath.row], options: [])
        
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
            " Mins remaining"
        }

        

        return mycell
    }

    override func viewDidAppear(animated: Bool) {
        var myRequestSummaryQuery = PFQuery(className: "Request")
        myRequestSummaryQuery.whereKey("userid", equalTo: PFUser.currentUser()!.objectId!)
        
        myRequestSummaryQuery.findObjectsInBackgroundWithBlock { (objects , error ) -> Void in
            
            myfoodname.removeAll(keepCapacity: true)
            myserves.removeAll(keepCapacity: true)
            myexpiry.removeAll(keepCapacity: true)
            mystatus.removeAll(keepCapacity: true)
            myimageFiles.removeAll(keepCapacity: true)
            myposteduser.removeAll(keepCapacity: true)
            myfdescription.removeAll(keepCapacity: true)
            myfoodType.removeAll(keepCapacity: true)
            mypAddress.removeAll(keepCapacity: true)
            mypCity.removeAll(keepCapacity: true)
            mypState.removeAll(keepCapacity: true)
            myphonenumber.removeAll(keepCapacity: true)
            mypostedAt.removeAll(keepCapacity: true)
            mypostObjectIds.removeAll(keepCapacity: true)
            
            if let objects = objects {
                
                for object in objects {
                    
                    myfoodname.append(object["foodname"]! as! String)
                    myserves.append(object["serves"]! as! String)
                    myexpiry.append(object["expiry"]! as! NSDate)
                    myimageFiles.append(object["image"] as! PFFile)
                    mystatus.append(object["status"] as! String)
                    myposteduser.append(object["contactname"] as! String)
                    myfdescription.append(object["fooddescription"] as! String)
                    //myfoodType.append(<#T##newElement: String##String#>)
                    mypAddress.append(object["pickupaddress"] as! String)
                    mypCity.append(object["pickupcity"] as! String)
                    mypState.append(object["pickupstate"] as! String)
                    myphonenumber.append(object["contactphone"] as! String)
                    mypostedAt.append(object.createdAt! as! NSDate)
                    mypostObjectIds.append(object.objectId!)
                    
                    self.tableView.reloadData()
                    
                }
            }
            
        }
    }

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("myFoodDetailSegue", sender: self)
        mycurrentIndex = indexPath.row
    }

    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            var query = PFQuery(className: "Request")
            
            query.getObjectInBackgroundWithId(mypostObjectIds[indexPath.row], block: { (object, error ) -> Void in
                
                if error != nil{
                    print (error)
                }else
                {
                    if let object = object {
                        
                     object.deleteInBackgroundWithBlock({ (success, error ) -> Void in
                        if success == true {
                            self.tableView.reloadData()
                            
                        }else{
                            print(error)
                        }
                        
                     })
                        
                    }
                    
                    
                }
                
            })
            
            
            
            
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
