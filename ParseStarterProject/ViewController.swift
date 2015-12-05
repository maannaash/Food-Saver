/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    var signupActive = true
    
    
    func displayAlert(title:String, Message:String){
        
        var alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func SignUpButtonPressed(sender: UIButton) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in Form", Message: "Please enter a username and password")
            
        }else{
            
            //Sign up Code
            
        }
        
        
    }
    
    @IBAction func LoginButton(sender: AnyObject) {
       
        
        if signupActive == true {
            
            signUpButton.setTitle("Login", forState: UIControlState.Normal)
            loginButton.setTitle("New User ? Sign Up", forState: UIControlState.Normal)
            signupActive = false
            
        }else{
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            loginButton.setTitle("Already Registered ? Login", forState: UIControlState.Normal)
            signupActive = true

        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 600
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
