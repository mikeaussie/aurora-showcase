//
//  ViewController.swift
//  aurora-showcase
//
//  Created by Mike Piatin on 8/05/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            
        }
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: nil) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
                    // give a popup notification here
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with Facebook. \(accessToken)")
                
                    //here is the reference to the DataService file
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    //here is the simplified closure, names can be ignored as well as "-> Void", if the code is meant to be executed right away (no postponed calls back)
                    
                    //xcode is showing the error, unless the real values are typed in provider and token fields rather then "String!"
                    //now grab and store firebase user ID
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged in! \(authData)")
                        
                    //now save user details using NSUserDefaults
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        
                    //now login to a new viewController
                        
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                        
                    }
                    
                })
                
                
            }
            
        }
        
        
    }
    
    @IBAction func emailBtnPressed(sender: UIButton!) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        //if the account does not exist, create a new user
                       DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                        //there is quite a few situations that might be requiring the alert (matching user email, etc.)
                        
                        if error != nil {
                            
                            self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else. \(error)")
                        } else {
                            NSUserDefaults.standardUserDefaults().setValue(result [KEY_UID], forKey: KEY_UID)
                            
                            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                        }
                       })
                    
                    } else {
                        self.showErrorAlert("Could not login", msg: "Please check your login or password")
                    }
                    
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil) //if the account exists
                }
                
            })
        } else {
            showErrorAlert("Email & Password required", msg: "You must enter an email and a password")
        }
        
    
    }
    
    //reusable function
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    }





