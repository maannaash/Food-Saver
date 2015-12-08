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
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    //////////////Display Alert func
    
    func displayAlert(title:String, Message:String){
        
        var alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //////////////Sign Up Button Pressed func
    
    @IBAction func SignUpButtonPressed(sender: UIButton) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in Form", Message: "Please enter a username and password")
            
        }else{
            
            
            activityIndicator = UIActivityIndicatorView(frame:CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Please try again !"
            
            if signupActive == true {
                
                
                var user = PFUser()
                
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock({ (success, error ) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    
                    if error == nil {
                        
                        // successful sign up
                        self.performSegueWithIdentifier("tabBarSegue", sender: self)
                        
                    }else{
                        
                        if let errorString = error?.userInfo["error"] as? String {
                            errorMessage = errorString
                            
                        }
                        self.displayAlert("Failed Sign Up", Message: errorMessage)
                    }
                })
            }else {
                //login code
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error ) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil{
                        
                        self.performSegueWithIdentifier("tabBarSegue", sender: self)
                    }else{
                        
                        if let errorString = error?.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed Login", Message: errorMessage)
                    }
                })
            }
            
        }
        
        
    }
    
    //////////////Login Button Pressed func
    
    
    
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
        
        //scrollView.contentSize.height = 600
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
