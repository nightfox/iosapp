//
//  ViewController.swift
//  myfirstapp
//
//  Created by Anirvan Mandal on 09/12/15.
//  Copyright © 2015 Anirvan Mandal. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBAction func loginButton(sender: UIButton) {
        let email = self.loginEmail.text
        let password = self.loginPassword.text
        
        if (email != nil && password != nil) {
           print(email!)
            print(password!)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
//        self.performSegueWithIdentifier("showSecondController", sender: self)
        super.viewDidAppear(animated)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
//            self.storyboard.performSegueWithIdentifier:@"segueToSecondViewController" sender:self]
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email"]
            loginView.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signupUser(sender: UIButton) {
        
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            // Process error later
        } else if result.isCancelled {
            // Handle cancellations later
        } else {
            self.signupUser();
            print(FBSDKAccessToken.currentAccessToken().tokenString)
        }
    }
    
    func signupUser()
    {
        let apiSignup = ApiHelper()
        apiSignup.makePostRequest(["id": "abcd"], successHandler: { (request: String) -> Bool in
                print("a")
            return true
            }, errorHandler: { (a: AnyObject, b: AnyObject?) -> Int in
                print("b")
                return 1
            }
        )
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name,email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

}

