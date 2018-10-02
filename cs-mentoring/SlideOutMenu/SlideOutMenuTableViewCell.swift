//
//  SlideOutMenuTableViewCell.swift
//  cs-mentoring
//
//  Created by Patricia on 9/24/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class SlideOutMenuTableViewCell: UITableViewCell {
    
    var menuItem : SlideOutMenuItems? {
        didSet{
            guard let item = menuItem else {return}
            self.menuIcon.image = item.menuIcon
            self.menuLabel.text = item.menuLabel
        }
    }
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let userTypeString = UserDefaults.standard.string(forKey: "userType") ?? "No type set"
        if userTypeString == "Student" {
            self.menuLabel.textColor = .white
            backgroundColor = UIColor.SeaBlue
        } else if userTypeString == "Mentor" {
            self.menuLabel.textColor = UIColor.RoyalPurple
            backgroundColor = UIColor.CloudBlue
        } else if userTypeString == "Admin" {
            self.menuLabel.textColor = .white
            backgroundColor = UIColor.PlumPurple
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
