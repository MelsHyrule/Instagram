//
//  PostsViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var posts: [PFObject] = []
    var refreshControl: UIRefreshControl!
    var isMoreDataLoading = false
    
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: UIControlEvents.valueChanged)
        
        postsTableView.insertSubview(refreshControl, at: 0)
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
            if segue.identifier == "createPost" {
                //do nothing
            } else {
                //self.performSegue(withIdentifier: "makePost", sender:  nil)
                
                let cell = sender as! UITableViewCell
                if let indexPath = postsTableView.indexPath(for: cell){
                    let post = posts[indexPath.row]
                    let detailPostViewController = segue.destination as! DetailPostViewController
                    detailPostViewController.post = post
                    postsTableView.deselectRow(at: indexPath, animated: true)
                }
            }
            
        }
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
    
    func fetchPosts() {
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
            self.refreshControl.endRefreshing()
        }
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
    }
    
    
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) { //it does nothing basically
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = postsTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - postsTableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && postsTableView.isDragging) {
                isMoreDataLoading = true
                print(" T H I  S I S H A P P E N I N G")
                loadMoreData()
                // ... Code to load more results ...
                //fetchPosts()
            }
        }
    }
    
    
    func loadMoreData() {       //it does nothing basically
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        
        query.whereKey("author", equalTo: PFUser.current())
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            
            if let posts = posts  {
                
                let dataDictionary = posts
                //print(dataDictionary)
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary
                // Store the returned array of dictionaries in our posts property
                self.posts += responseDictionarys
                // Reload the tableView now that there is new data
                self.postsTableView.reloadData()
                
            } else {
                //print(error.localizedDescription)
                print ("error in infinite scroll")
            }
            self.postsTableView.reloadData()
            self.isMoreDataLoading = false
            
            //task.resume()
        }
    }

    */
}
