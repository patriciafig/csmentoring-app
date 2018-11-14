//
//  UserProfilePictureCollectionViewCell.swift
//  cs-mentoring
//
//  Created by Patricia on 9/7/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class UserProfilePictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
}

func prepare (for segue: UIStoryboardSegue, sender: Any?){
    if (segue.identifier == ""){
        
    }
    
}
