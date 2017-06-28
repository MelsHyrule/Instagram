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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //selectPic()
        
        myPic.image = myPicImage
        
        //resize(image: myPicImage, newSize: <#T##CGSize#>)
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
            print("I finished posting")
        }
        
        self.dismiss(animated: true, completion: nil)
        //this *should* dismiss the yellow view and go back to home
    }

}
