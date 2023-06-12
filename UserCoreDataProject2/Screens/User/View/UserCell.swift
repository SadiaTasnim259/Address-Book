//
//  UserCell.swift
//  UserCoreDataProject2
//
//  Created by Sadia on 8/6/23.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var user: UserEntity?{
        didSet{ // property observer
            userConfiguration()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func userConfiguration(){
        guard let user else{ return }
        
        fullNameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        phoneNumberLabel.text = "Phone: \(user.phoneNumber ?? "")"
        
        //fetch image
        let imageURL = URL.documentsDirectory.appending(components: user.imageName ?? "").appendingPathExtension("png")
        profileImageView.image = UIImage(contentsOfFile: imageURL.path)
    }
}
