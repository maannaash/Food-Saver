//
//  FoodRequestTableViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

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


class FoodRequestTableViewController: UITableViewController , CLLocationManagerDelegate {

    
    var locationManager = CLLocationManager()
    
    
    @IBAction func mapButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("mapSegue", sender: self)
    }
    
    @IBOutlet var mapbuttonLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapbuttonLabel.tintColor = UIColor(patternImage: UIImage(named: "fbg1.png")!)
        
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
        
        var currentIndex = 0
        
        let usrid = PFUser.currentUser()!.objectId!
        
        //let predicate = NSPredicate(format: "userid != 'usrid' AND status != 'Taken'")
        
        var foodRequestSummaryQuery = PFQuery(className: "Request")
        
        
        foodRequestSummaryQuery.whereKey("userid", notEqualTo: PFUser.currentUser()!.objectId!)
        foodRequestSummaryQuery.whereKey("status", notEqualTo: "Taken")
        foodRequestSummaryQuery.whereKey("pickupcity", equalTo: userCity)
        
        
        
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
                
                print (objects.count)
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
        
        //Distance
        
        
        let latitude:CLLocationDegrees = userLatitude
        let longitude:CLLocationDegrees = userLongitude
        let crntuserloc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let flatitude:CLLocationDegrees = alllatitude[indexPath.row]
        let flongitude:CLLocationDegrees = alllongitude[indexPath.row]
        let feeduserloc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(flatitude, flongitude)
        
        var crntloc: CLLocation = CLLocation.init(latitude: latitude, longitude: longitude)
        var fusrloc: CLLocation = CLLocation.init(latitude: flatitude, longitude: flongitude)
        
        var distance: CLLocationDistance = fusrloc.distanceFromLocation(crntloc)
        
        
        var distinMiles = distance *  0.000621371192
        foodcell.distanceAway.text = String(format: "%.2f", distinMiles) + " miles away "
        
        //
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data , error ) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                foodcell.postedImage.image = downloadedImage
            }
        }
        
        
        var tempimageView = UIImageView(frame: CGRectMake(10, 10, foodcell.frame.width - 10, foodcell.frame.height - 10))
        
        
        
        
        if foodstatus[indexPath.row] == "Available" {
            
            tempimageView = UIImageView(image: UIImage(named: "lgc.png"))
            foodcell.backgroundView = tempimageView
            foodcell.statusImage.image = UIImage(named: "bgc.png")
            
        }else {
            if foodstatus[indexPath.row] == "Blocked"{
                
                tempimageView = UIImageView(image: UIImage(named: "loc.png"))
                foodcell.backgroundView = tempimageView
                foodcell.statusImage.image = UIImage(named: "doc.png")

                
            }
        }

        
        
        //print(indexPath.row)
        //print(foodstatus[indexPath.row])
        foodcell.foodName.text = foodname[indexPath.row]
        foodcell.servesLabel.text = "Serves " + String(serves[indexPath.row])
        foodcell.statusLabel.text = foodstatus[indexPath.row]
        foodcell.descriptionLabel.text = fdescription[indexPath.row]
        var postedusertext = "Posted by : " + String(posteduser[indexPath.row])
        
        
      
        
        // Posted Time
        let pcalendar = NSCalendar.currentCalendar()
        let pcomponents = pcalendar.components([.Day, .Hour, .Minute, .Second], fromDate: postedAt[indexPath.row], toDate: NSDate(), options: [])


        
        var pdaytext = " d ago "
        var phourtext = " hr ago "
        
        if pcomponents.day > 0 {
            foodcell.postedByUser.text = postedusertext + " " + String(pcomponents.day) + pdaytext
        } else {
            foodcell.postedByUser.text = postedusertext + " " + String(pcomponents.hour) + phourtext        }

        
        // Remaining Time
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: expiry[indexPath.row], options: [])
        
        var daytext = " d "
        var hourtext = " hr & "

        
        if components.day > 0 {
            foodcell.expiryLabel.text = String(components.day) + daytext + String(components.hour) + " hr rem"
        } else {
            foodcell.expiryLabel.text = String(components.hour) + hourtext + String(components.minute) +
            " min rem"
        }
        
        return foodcell
    }
    
    
    override func viewDidAppear(animated: Bool) {
        var foodRequestSummaryQuery = PFQuery(className: "Request")
        
        foodRequestSummaryQuery.whereKey("userid", notEqualTo: PFUser.currentUser()!.objectId!)
        foodRequestSummaryQuery.whereKey("status", notEqualTo: "Taken")
        foodRequestSummaryQuery.whereKey("pickupcity", equalTo: userCity)
        
        
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
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        var currentLocation:CLLocation = locations[0]
        var latitude = currentLocation.coordinate.latitude
        var longitude = currentLocation.coordinate.longitude
        userLatitude = currentLocation.coordinate.latitude
        userLongitude = currentLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error ) -> Void in
            
            if error != nil {
                
                print("Error" + (error?.localizedDescription)!)
                return
                
            }
            
            var subthoroughfare = ""
            var thoroughfare = ""
            if placemarks?.count > 0 {
                
                if let p = placemarks?.first {
                    
                    
                    self.locationManager.stopUpdatingLocation()
                    
                    
                    if p.subThoroughfare != nil {
                        
                        subthoroughfare = p.subThoroughfare!
                        
                    }
                    
                    if p.thoroughfare != nil {
                        
                        thoroughfare = p.thoroughfare!
                        
                    }
                    userAddress = "\(subthoroughfare) \(thoroughfare)"
                    userCity = p.locality!
                    userState = p.administrativeArea!
                    userCountry = p.country!
                    userpostalCode = p.postalCode!
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("Error" + error.localizedDescription)
        
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
