//
//  FoodDetailViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/9/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
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
        var postedAt = [NSDate]()*/
        
        
        print(currentIndex)
        print(postedAt)
        
        postedByUserName.text = posteduser[currentIndex]
        postedOnDate.text = String(postedAt[currentIndex])
        postedFoodTitle.text = foodname[currentIndex]
        postedFoodDescription.text = fdescription[currentIndex]
        postedServesCount.text = serves[currentIndex]
       // postedExpiry.text = String(expiry[currentIndex])
        postedPhone.text = phonenumber[currentIndex]
        postedAddress.text = pAddress[currentIndex]
        postedCity.text = pCity[currentIndex]
        postedState.text = pState[currentIndex]
        
        imageFiles[currentIndex].getDataInBackgroundWithBlock { (data , error ) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                self.postedFoodImage.image = downloadedImage
            }
        }
        
        

        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: expiry[currentIndex], options: [])
        
        
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
            postedExpiry.text = String(components.day) + daytext + String(components.hour) + " Hours remaining"
        } else {
            postedExpiry.text = String(components.hour) + hourtext + String(components.minute) +
            " Minutes remaining"
        
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
