//
//  NewsCollectionViewCell.swift
//  cs-mentoring
//
//  Created by Patricia on 10/14/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private(set) var imageView: UIImageView! {
        didSet {
            imageView.backgroundColor = .SkyBlue
        }
    }
    @IBOutlet private(set) var descriptionLabel: UILabel!
    @IBOutlet private(set) var timestampLabel: UILabel!
    
}
