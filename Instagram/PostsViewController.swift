//
//  PostsViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource {
    
    
    // Post information
    
    var postImage = UIImage(named: "imageName")
    
    @IBAction func createPost(_ sender: Any) {
       selectPic()
    }

    func selectPic(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        //        vc.sourceType = UIImagePickerControllerSourceType.camera
        self.present(vc, animated: true, completion: nil)
        print ("Stuff happened")
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        // Do something with the images (based on your use case)
        postImage = originalImage
        if (postImage == nil) {
            print("it nil")
        }
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "createPost", sender: self)
    }

    
    //Table View configurations Information
    
    @IBOutlet weak var postsTableView: UITableView!
    var posts: [PFObject] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        let caption = post["caption"] as! String
        let image = post["media"] as! PFFile
        let author = post["author"] as! PFUser

        /*
         if let user = post["user"] as? PFUser {
         // User found! update username label with username
         cell.usernameLabel.text = user.username
         } else {
         // No user found, set default username
         cell.usernameLabel.text = "😈"
         }
         */
        
        cell.captionLabel.text = caption
        cell.postPictureImageView.file = image
        cell.postPictureImageView.loadInBackground()
        cell.usernameLabel.text = author.username
        
        return cell
    }
    
    
    
    // GENERAL STUFF
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onTimer), for: UIControlEvents.valueChanged)

        postsTableView.insertSubview(refreshControl, at: 0)
        
        refreshControl.endRefreshing()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let photoMapViewController = segue.destination as! PhotoMapViewController
        
        if let thisPic = postImage {
            photoMapViewController.myPicImage = thisPic
        } else {
            print ("nil found booooiiiiii")
        }
        
    }
    
    func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.posts = posts
                self.postsTableView.reloadData()
            } else {
                print(error?.localizedDescription as? String)
            }
        }
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
    }

    
    
}
