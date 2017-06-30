//
//  PostCell.swift
//  Instagram
//
//  Created by Melody Ann Seda Marotte on 6/28/17.
//  Copyright © 2017 Melody Ann Seda Marotte. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    var post: PFObject! {
        didSet{
            let caption = post["caption"] as! String
            let image = post["media"] as! PFFile
            let author = post["author"] as! PFUser
            
            print (image.url)
            
            captionLabel.text = caption
            postPictureImageView.file = image
            postPictureImageView.loadInBackground()
            usernameLabel.text = author.username

            let height = postPictureImageView.image?.size.height
            let width = postPictureImageView.image?.size.width
            
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            
            //postPictureWidthConstraint.constant = screenWidth
            //postPictureHeightConstraint.constant = (height)! * (screenWidth) / (width)!
            
        }
    
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postPictureImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var postPictureHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postPictureWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
