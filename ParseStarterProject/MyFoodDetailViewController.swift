//
//  MyFoodDetailViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/9/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MyFoodDetailViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var myFoodTitleText: UITextField!
    
    @IBOutlet var myFoodDescriptionText: UITextView!
    
    @IBOutlet var myServesText: UITextField!

    
    @IBOutlet var myExpiryLabel: UILabel!
    
    @IBOutlet var myPhoneText: UITextField!
    
    @IBOutlet var myAddress: UILabel!
    
    @IBOutlet var myCity: UILabel!
    
    @IBOutlet var myState: UILabel!
    
    @IBOutlet var myFoodImage: UIImageView!
    
    @IBOutlet var availableButton: UIButton!
    
    @IBOutlet var blockedButton: UIButton!
    
    @IBOutlet var takenButton: UIButton!
    
    var editActive = true
    
    @IBOutlet var editbuttonLabel: UIButton!
    
    
    @IBAction func availableButtonPressed(sender: AnyObject) {
     
        availableButton.backgroundColor = UIColor.greenColor()
        blockedButton.backgroundColor = UIColor.clearColor()
        takenButton.backgroundColor = UIColor.clearColor()
        
        var query = PFQuery(className: "Request")
        query.getObjectInBackgroundWithId(String(mypostObjectIds[mycurrentIndex])) { (object, error ) -> Void in
            
            if error != nil {
                print(error)
            }else{
                object!["status"] = "Available"
                object?.saveInBackground()
                
            }
        }
        
    }
    
    
    @IBAction func blockedButtonPressed(sender: AnyObject) {
        
        availableButton.backgroundColor = UIColor.clearColor()
        blockedButton.backgroundColor = UIColor.brownColor()
        takenButton.backgroundColor = UIColor.clearColor()
        
        var query = PFQuery(className: "Request")
        query.getObjectInBackgroundWithId(String(mypostObjectIds[mycurrentIndex])) { (object, error ) -> Void in
            
            if error != nil {
                print(error)
            }else{
                object!["status"] = "Blocked"
                object?.saveInBackground()
                
            }
        }
        
    }

    
    @IBAction func takenButtonPressed(sender: AnyObject) {
        
        availableButton.backgroundColor = UIColor.clearColor()
        blockedButton.backgroundColor = UIColor.clearColor()
        takenButton.backgroundColor = UIColor.redColor()
        
        var query = PFQuery(className: "Request")
        query.getObjectInBackgroundWithId(String(mypostObjectIds[mycurrentIndex])) { (object, error ) -> Void in
            
            if error != nil {
                print(error)
            }else{
                object!["status"] = "Taken"
                object?.saveInBackground()
                
            }
        }

    }
    
    
    @IBAction func editButtonPressed(sender: AnyObject) {
        
        
        
        if editActive == true {
            myFoodTitleText.userInteractionEnabled = true
            myFoodDescriptionText.userInteractionEnabled = true
            myServesText.userInteractionEnabled = true
            //myFoodTypeText.userInteractionEnabled = true
            myPhoneText.userInteractionEnabled = true
            editActive = false
            editbuttonLabel.setTitle("Save", forState: .Normal)
            
        }else {
            var query = PFQuery(className: "Request")
            query.getObjectInBackgroundWithId(String(mypostObjectIds[mycurrentIndex])) { (object, error ) -> Void in
                
                if error != nil {
                    print(error)
                }else{
                    object!["foodname"] = self.myFoodTitleText.text
                    object!["fooddescription"] = self.myFoodDescriptionText.text
                    object!["serves"] = self.myServesText.text
                    object!["contactphone"] = self.myPhoneText.text
                    
                    object?.saveInBackground()
                    self.myFoodTitleText.userInteractionEnabled = false
                    self.myFoodDescriptionText.userInteractionEnabled = false
                    self.myServesText.userInteractionEnabled = false
                    //  self.myFoodTypeText.userInteractionEnabled = false
                    self.myPhoneText.userInteractionEnabled = false
                    
                    
                }
            }
            editActive = true
            editbuttonLabel.setTitle("Edit", forState: .Normal)
        }
        
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100),
            NSFontAttributeName : UIFont(name: "Futura", size: 20)!
        ]
        
        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100)
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, width, height))
        imgView.image = UIImage(named: "fbg1.png")!
        imgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imgView)
        self.view.sendSubviewToBack(imgView)
        
        /*
        let mwidth = UIScreen.mainScreen().bounds.size.width
        let mheight = UIScreen.mainScreen().bounds.size.height
        
        var mimgView = UIImageView(frame: CGRectMake(0, 0, mwidth, mheight))
        mimgView.image = UIImage(named: "bg22.png")!
        mimgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(mimgView)
        self.view.sendSubviewToBack(mimgView)*/

        
        
        // Do any additional setup after loading the view.
        
        if mystatus[mycurrentIndex] == "Available" {
            
            availableButton.backgroundColor = UIColor.greenColor()
            blockedButton.backgroundColor = UIColor.clearColor()
            takenButton.backgroundColor = UIColor.clearColor()
        }
        
        if mystatus[mycurrentIndex] == "Blocked" {
            
            availableButton.backgroundColor = UIColor.clearColor()
            blockedButton.backgroundColor = UIColor.brownColor()
            takenButton.backgroundColor = UIColor.clearColor()
        }
        if mystatus[mycurrentIndex] == "Taken" {
            
            availableButton.backgroundColor = UIColor.clearColor()
            blockedButton.backgroundColor = UIColor.clearColor()
            takenButton.backgroundColor = UIColor.redColor()
        }
        
        
        myFoodTitleText.userInteractionEnabled = false
        myFoodDescriptionText.userInteractionEnabled = false
        myServesText.userInteractionEnabled = false
      //  myFoodTypeText.userInteractionEnabled = false
        myPhoneText.userInteractionEnabled = false
        
        
        //myPostedOnDate.text = String(mypostedAt[mycurrentIndex])
        myFoodTitleText.text = myfoodname[mycurrentIndex]
        myFoodDescriptionText.text = myfdescription[mycurrentIndex]
        myServesText.text = myserves[mycurrentIndex]
        //myFoodTypeText.text = myfoodType[mycurrentIndex]
        myPhoneText.text = myphonenumber[mycurrentIndex]
        myAddress.text = mypAddress[mycurrentIndex]
        myCity.text = mypCity[mycurrentIndex]
        myState.text = mypState[mycurrentIndex]
        
        myimageFiles[mycurrentIndex].getDataInBackgroundWithBlock { (data , error ) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                self.myFoodImage.image = downloadedImage
            }
        }
        
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: myexpiry[mycurrentIndex], options: [])
        
        
        var daytext = ""
        var hourtext = ""
        daytext = " d & "
        hourtext = " hr & "

        
        
        
        if components.day > 0 {
            myExpiryLabel.text = "Expires in " + String(components.day) + daytext + String(components.hour) + " hr"
        } else {
            myExpiryLabel.text = "Expires in " + String(components.hour) + hourtext + String(components.minute) + " min"
            
        }
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.myFoodTitleText.resignFirstResponder()
        self.myFoodDescriptionText.resignFirstResponder()
        self.myServesText.resignFirstResponder()
        self.myPhoneText.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
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
