//
//  InterestsCollectionViewCell.swift
//  cs-mentoring
//
//  Created by Patricia on 9/3/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 6
        layer.borderColor = UIColor(red: 188 / 255, green: 234 / 255, blue: 253 / 255, alpha: 1).cgColor
        layer.borderWidth = 1
    }
    
    @IBOutlet private(set) var interestLabel: UILabel! {
        didSet {
            interestLabel.textColor = UIColor(red: 38 / 255, green: 153 / 255, blue: 251 / 255, alpha: 1)
        }
    }
}
