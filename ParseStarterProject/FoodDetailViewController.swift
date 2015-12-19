//
//  FoodDetailViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/9/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import MessageUI
import Parse

class FoodDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    
    @IBOutlet var postedByUserName: UILabel!
    
    @IBOutlet var postedOnDate: UILabel!
    
    @IBOutlet var postedFoodImage: UIImageView!
    
    @IBOutlet var postedFoodTitle: UILabel!
    
    @IBOutlet var postedFoodDescription: UILabel!
    
    @IBOutlet var postedFoodType: UILabel!
    
    @IBOutlet var postedServesCount: UILabel!
    
    @IBOutlet var postedExpiry: UILabel!
    
    @IBOutlet var postedPhone: UILabel!
    
    @IBOutlet var postedAddress: UILabel!
    
    @IBOutlet var postedCity: UILabel!
    
    @IBOutlet var postedState: UILabel!
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var postedFoodTitle2: UILabel!
    
    @IBAction func directionsButtonPressed(sender: AnyObject) {
        
        performSegueWithIdentifier("directionMapSegue", sender: self)
        
    }
    
    
    
    @IBAction func callButtonPressed(sender: AnyObject) {
        
        print("Call pressed")
        
        var unfmtphone = String(postedPhone.text!)
        var newPhone = ""
        
        for i in unfmtphone.characters {
            switch (i){
                case "0","1","2","3","4","5","6","7","8","9" : newPhone = newPhone + String(i)
                default : print("Removed invalid character.")
            }
        }
        
        if let url = NSURL(string: "telprompt://\(newPhone)"){
            UIApplication.sharedApplication().openURL(url)
        }
}


@IBAction func sendMessageButtonPressed(sender: AnyObject) {
    
    print("Msg Pressed")
    
    let messageVC = MFMessageComposeViewController()
    
    
    let unfmtphone = String(postedPhone.text!)
    var newPhone = ""
    
    for i in unfmtphone.characters {
        switch (i){
        case "0","1","2","3","4","5","6","7","8","9" : newPhone = newPhone + String(i)
        default : print("Removed invalid character.")
        }
    }
    
    
    let msg1 = "Hi " + posteduser[currentIndex] + " I am intrested to pick up your extra food - " + foodname[currentIndex]
    let msg2 = ". Please block the food and I will come and pick it up. Thanks "
    
    let newmessage = msg1 + msg2 + (PFUser.currentUser()?.username)! + "."
    
    messageVC.body = newmessage
    messageVC.recipients = [newPhone]
    messageVC.messageComposeDelegate = self
    
    self.presentViewController(messageVC, animated: true, completion: nil)
    
}

func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
    
    switch (result.rawValue) {
    case MessageComposeResultCancelled.rawValue:
        print("Message was cancelled")
        self.dismissViewControllerAnimated(true, completion: nil)
    case MessageComposeResultFailed.rawValue:
        print("Message failed")
        self.dismissViewControllerAnimated(true, completion: nil)
    case MessageComposeResultSent.rawValue:
        print("Message was sent")
        self.dismissViewControllerAnimated(true, completion: nil)
    default:
        break;
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

    //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2.png")!)
    
    // Do any additional setup after loading the view.
    
   // print(currentIndex)
   // print(postedAt)
    
    
    let formatter = NSDateFormatter()
    formatter.dateStyle = NSDateFormatterStyle.MediumStyle
    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
    
    let dateString = formatter.stringFromDate(postedAt[currentIndex])
    
    
    // Posted Time
    let pcalendar = NSCalendar.currentCalendar()
    let pcomponents = pcalendar.components([.Day, .Hour, .Minute, .Second], fromDate: postedAt[currentIndex], toDate: NSDate(), options: [])
    
    
    
    var pdaytext = " d ago "
    var phourtext = " hr ago "
    var agotext = ""
    
    if pcomponents.day > 0 {
        agotext = String(pcomponents.day) + pdaytext
    } else {
        agotext = String(pcomponents.hour) + phourtext        }
    

    
    
    
    postedByUserName.text = "Posted by : " + String(posteduser[currentIndex]) + " " + agotext
    //postedOnDate.text = dateString
    postedFoodTitle.text = foodname[currentIndex]
    postedFoodDescription.text = fdescription[currentIndex]
    postedServesCount.text = serves[currentIndex]
    // postedExpiry.text = String(expiry[currentIndex])
    postedPhone.text = phonenumber[currentIndex]
    postedAddress.text = pAddress[currentIndex]
    postedCity.text = pCity[currentIndex]
    postedState.text = pState[currentIndex]
    statusLabel.text = foodstatus[currentIndex]
    postedFoodTitle2.text = foodname[currentIndex]
    
    imageFiles[currentIndex].getDataInBackgroundWithBlock { (data , error ) -> Void in
        
        if let downloadedImage = UIImage(data: data!) {
            
            self.postedFoodImage.image = downloadedImage
        }
    }
    
    
    
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: expiry[currentIndex], options: [])
    
    
    var daytext = " d "
    var hourtext = " hr & "
    
    
    
    if components.day > 0 {
        postedExpiry.text = "Expires in " + String(components.day) + daytext + String(components.hour) + " hr"
    } else {
        postedExpiry.text = "Expires in " + String(components.hour) + hourtext + String(components.minute) + " min"
        
    }
    
    
    
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
