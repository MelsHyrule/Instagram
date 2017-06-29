//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myPic: UIImageView!
    @IBOutlet weak var myPicCaption: UITextField!
    
    var myPicImage : UIImage!
    var postCaption = ""
    var useCamera: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resize(image: myPicImage, newSize: CGSize(width: 375, height: 375))
        myPic.image = myPicImage
        
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
    
    @IBAction func onSharePressed(_ sender: Any) {
        postCaption = myPicCaption.text ?? ""
        Post.postUserImage(image: myPic.image, withCaption: postCaption) { (status: Bool, error: Error?) in
            if let error = error {
                print (error.localizedDescription)
            } else {
                print("I finished posting")
                //refresh table view
                
//                let postsViewController = segue.destination as! PostsViewController
//                postsViewController.postsTableView.reloadData()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    
}
