//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var profilePictureImageView: PFImageView!
    @IBOutlet weak var currentUsernameLabel: UILabel!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var posts: [PFObject] = []
    var userPosts: [PFObject] = []
    var username = ""
    var refreshControl: UIRefreshControl!
    var myProfilePicture : UIImage!
//    var myProfilePictureFile : PFFile!
//    let user = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUsernameLabel.text = PFUser.current()?.username as! String
        
        let user = PFUser.current()!
        profilePictureImageView.file = user["profilePicture"] as? PFFile
        profilePictureImageView.loadInBackground()
        
        
        
        postsCollectionView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: UIControlEvents.valueChanged)
        
        postsCollectionView.insertSubview(refreshControl, at: 0)
        postsCollectionView.dataSource = self
        
        let layout = postsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine: CGFloat  = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = (postsCollectionView.frame.size.width - interItemSpacingTotal) / cellsPerLine
        layout.itemSize = CGSize(width: width-1, height: width-1)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        fetchPosts()
        
        
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
        
        if (sender != nil) {
            if (segue.identifier == "makeProfilePic"){
                let choosePictureFromLocationViewController = segue.destination as! ChoosePictureFromLocationViewController
                choosePictureFromLocationViewController.makingPost = true
            } else {
                let cell = sender as! PostCollectionCell
                if let indexPath = postsCollectionView.indexPath(for: cell){
                    let post = self.posts[indexPath.row]
                    let detailPostViewController = segue.destination as! DetailPostViewController
                    detailPostViewController.post = post
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionCell", for: indexPath) as! PostCollectionCell
        
        let post = posts[indexPath.row]
        let image = post["media"] as! PFFile
        cell.postImageView.file = image
        cell.postImageView.loadInBackground()
        
        return cell
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.currentUser() will now be nil
            print("User signed out")
            //TODO: once user is signed out, go back to loging screen...
            self.performSegue(withIdentifier: "logoutSegue", sender:  nil)
        }
        
    }
    
    
    func fetchPosts() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current())
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            
            if let posts = posts  {
                //if current user = post author
                // do something with the array of object returned by the call
                self.posts = posts
                self.userPosts = posts
                
                self.postsCollectionView.reloadData()
                
                let user = PFUser.current()!
                self.profilePictureImageView.file = user["profilePicture"] as? PFFile
                self.profilePictureImageView.loadInBackground()
                
            } else {
                print(error?.localizedDescription as? String)
            }
            self.refreshControl.endRefreshing()
        }
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

    
}
