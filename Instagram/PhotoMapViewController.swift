//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myPic: UIImageView!
    @IBOutlet weak var myPicCaption: UITextField!
    
    var postImage = UIImage(named: "imageName")
    var postCaption = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        myPic.image = editedImage
        postImage = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSharePressed(_ sender: Any) {
        postCaption = myPicCaption.text ?? ""
        Post.postUserImage(image: myPic.image, withCaption: postCaption) { (status: Bool, error: Error?) in
            print("I finisherd posting")
        }
        
        
    }
    
    
    
}
