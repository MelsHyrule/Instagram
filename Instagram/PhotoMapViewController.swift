//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/27/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import AVFoundation
import Sharaku

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SHViewControllerDelegate {
    
    @IBOutlet weak var myPic: UIImageView!
    //@IBOutlet weak var myPicCaption: UITextField!
    @IBOutlet weak var myPicCaptionTextView: UITextView!
    
    var myPicImage : UIImage!
    var postCaption = ""
    var useCamera: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        postCaption = myPicCaptionTextView.text ?? ""
        myPicImage = resizeImage(image: myPicImage, targetSize: CGSize(width: 375, height: 375))
        myPic.image = myPicImage
        Post.postUserImage(image: myPic.image, withCaption: postCaption) { (status: Bool, error: Error?) in
            if let error = error {
                print (error.localizedDescription)      //we're having the error that its not saving the picture (Could not store file.)
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
/*
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
*/
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        // This is the rect that we've calculated out and this is what is actually used below
        let targetRect = CGRect(origin: CGPoint.zero, size: targetSize)
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: targetRect)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsGetCurrentContext()?.interpolationQuality = .high
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBAction func editPictureButton(_ sender: Any) {
        let imageToBeFiltered = myPicImage
        let vc = SHViewController(image: imageToBeFiltered!)
        vc.delegate = self
        self.present(vc, animated:true, completion: nil)
        
    }
    
    func shViewControllerImageDidFilter(image: UIImage) {
        // Filtered image will be returned here.
        myPicImage = image
        myPic.image = myPicImage
    }
    
    func shViewControllerDidCancel() {
        // This will be called when you cancel filtering the image.
    }

    
}
