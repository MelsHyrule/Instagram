//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
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
    
    @IBAction func onSignOut(_ sender: Any) {           //If option for sign out available, no chache sign in happens
        /*
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.currentUser() will now be nil
            print("User signed out")
            
            //TODO: once user is signed out, go back to loging screen...
            self.dismiss(animated: true, completion: {
            })
            self.dismiss(animated: true, completion: {
            })
            //so nice u run it twice (also its so u dismiss the tab and nav bar
        }
        */
        
    }
}
