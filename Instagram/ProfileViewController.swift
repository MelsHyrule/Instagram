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
    
    @IBOutlet weak var currentUsernameLabel: UILabel!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var posts: [PFObject] = []
    var userPosts: [PFObject] = []
    var username = ""
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUsernameLabel.text = PFUser.current()?.username as! String
        
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
            let cell = sender as! PostCollectionCell
            if let indexPath = postsCollectionView.indexPath(for: cell){
                let post = self.posts[indexPath.row]
                let detailPostViewController = segue.destination as! DetailPostViewController
                detailPostViewController.post = post
            }
        }
        
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
        
        /*
         
         let author = post["author"] as! PFUser
         
         print (image.url)
         
         cell.captionLabel.text = caption
         cell.usernameLabel.text = author.username
         */
        
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
        // Add code to be run periodically
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
            } else {
                print(error?.localizedDescription as? String)
            }
            self.refreshControl.endRefreshing()
        }
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
    }
    
    
}
