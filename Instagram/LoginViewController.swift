 //
 //  LoginViewController.swift
 //  Instagram
 //
 //  Created by Melody Ann Seda Marotte on 6/27/17.
 //  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
 //
 
 import UIKit
 import Parse
 
 class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func onSignIn(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print ("You're logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                //
            }
        }
        
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        // set user properties
        newUser.username = usernameField.text as! String
        //newUser.email = emailLabel.text
        newUser.password = passwordField.text as! String
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                
                /*
                if (error["code"] == 202) {
                    print ("Username is taken")
                }*/
  
            } else {
                print ("User added")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
        }
        
    }
    
 }
