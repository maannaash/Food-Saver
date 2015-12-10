//
//  NewRequestUIViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import CoreLocation


var userAddress:String = ""
var userCity:String = ""
var userState:String = ""
var userCountry:String = ""
var userpostalCode:String = ""
var userLatitude:CLLocationDegrees = CLLocationDegrees()
var userLongitude:CLLocationDegrees = CLLocationDegrees()



class NewRequestUIViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate  {
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var contactName: UITextField!
    
    @IBOutlet var contactPhone: UITextField!
    
    @IBOutlet var ExtraFoodName: UITextField!
    
    @IBOutlet var foodDescription: UITextField!
    
    @IBOutlet var servesHowMany: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var pickUpAddress: UITextField!
    
    @IBOutlet var pickUpCity: UITextField!
    
    @IBOutlet var pickUpState: UITextField!
    
    @IBOutlet var foodImage: UIImageView!
    
    var activityIndicator = UIActivityIndicatorView()
    
    var locationManager = CLLocationManager()
    
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        // PFUser.logOutInBackground()
        // performSegueWithIdentifier("loginSegue", sender: self)
        
        
    }
    
    
    
    @IBAction func postImageButtonPressed(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.foodImage.image = image
    }
    
    
    @IBAction func sendButtonPressed(sender:
        AnyObject) {
            
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
            var request = PFObject(className: "Request")
            
            request["userid"] = PFUser.currentUser()?.objectId
            request["contactname"] = contactName.text
            request["contactphone"] = contactPhone.text
            request["foodname"] = ExtraFoodName.text
            request["fooddescription"] = foodDescription.text
            request["serves"] = servesHowMany.text
            request["expiry"] = datePicker.date
            request["pickupaddress"] = pickUpAddress.text
            request["pickupcity"] = pickUpCity.text
            request["pickupstate"] = pickUpState.text
            request["pickuplatitude"] = userLatitude
            request["pickuplongitude"] = userLongitude
            request["status"] = "Available"
            
            
            
            let imageData = UIImageJPEGRepresentation(foodImage.image!, 0.5)
            
            let imageFile = PFFile(name: "foodimage.jpg", data: imageData!)
            
            request["image"] = imageFile
            
            request.saveInBackgroundWithBlock { (success, error ) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                
                if error == nil {
                    
                    //success
                    print("Success")
                }else{
                    
                    print(error)
                    
                }
            }
            
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        self.pickUpAddress.text = userAddress
        self.pickUpCity.text  = userCity
        self.pickUpState.text = userState
        
        
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
    
    
    override func viewDidAppear(animated: Bool) {
        
        self.pickUpAddress.text  = userAddress
        self.pickUpCity.text = userCity
        self.pickUpState.text  = userState
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
