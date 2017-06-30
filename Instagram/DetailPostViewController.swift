//
//  DetailPostViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/28/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailPostViewController: UIViewController {
//has no initializers?
    
    @IBOutlet weak var postPicturePFImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var captionTextView: UITextView!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = post["media"] as! PFFile
        postPicturePFImageView.file = image
        postPicturePFImageView.loadInBackground()
        
        let author = post["author"] as! PFUser
        usernameLabel.text = author.username
        
        //date posted
        let date = post.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date as! Date)
        datePostedLabel.text = dateString as! String
        
        captionTextView.text = post["caption"] as! String
        
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

}
