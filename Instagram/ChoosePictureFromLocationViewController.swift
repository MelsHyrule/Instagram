//
//  ChoosePictureFromLocationViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/28/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import AVFoundation
import Sharaku

class ChoosePictureFromLocationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var cameraRollBool: Bool = false
    var myPicImage : UIImage!
    var makingPost: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        photoMapViewController.useCamera = cameraRollBool
        photoMapViewController.myPicImage = myPicImage

        if (segue.identifier == "makePost") {
            print("making post")
            photoMapViewController.makingPost = true
        } else if (segue.identifier == "makeProfilePic") {
            print("making prof pic")
//            let photoMapViewController = segue.destination as! PhotoMapViewController
//            photoMapViewController.useCamera = cameraRollBool
//            photoMapViewController.myPicImage = myPicImage
            photoMapViewController.makingPost = false

//            let profileViewController = segue.destination as! ProfileViewController
//            profileViewController.myProfilePicture = myPicImage
        }
        
    }
    
    
    @IBAction func cameraRollButton(_ sender: Any) {
        cameraRollBool = true
        selectPic()
        //self.performSegue(withIdentifier: "makePost", sender:  nil)
    }
    
    @IBAction func takePictureButton(_ sender: Any) {
        cameraRollBool = false
        selectPic()
        //self.performSegue(withIdentifier: "makePost", sender:  nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func selectPic(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        let cameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        if (cameraAvailable && cameraRollBool) {
            print("Camera is available 📸 and willing to be used")
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
        
        myPicImage = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        
        if (!makingPost) {
            performSegue(withIdentifier: "makePost", sender: self)
        } else {
            performSegue(withIdentifier: "editProfPic", sender: self)    //this segue is not working
        }
    }
        
    
}
