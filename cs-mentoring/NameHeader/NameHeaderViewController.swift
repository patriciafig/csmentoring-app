//
//  NameHeaderViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/21/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class NameHeaderViewController: UIViewController {
    
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var userType: UILabel!
    
    
    @IBAction private func editButtonTapped(_ sender: UIButton) {
        // TODO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userTypeString = UserDefaults.standard.string(forKey: "userType")
        
        userName.text = UserDefaults.standard.string(forKey: "userFullName") ?? "No name set!"
        userType.text = userTypeString
        
        if userTypeString == "Student" {
            userName.textColor = UIColor(red: 38 / 255, green: 153 / 255 , blue: 251 / 255, alpha: 1)
            userType.textColor = UIColor(red: 38 / 255, green: 153 / 255 , blue: 251 / 255, alpha: 1)
            view.backgroundColor = UIColor(red: 241 / 255, green: 249 / 255, blue: 1, alpha: 1)
        } else if userTypeString == "Mentor" {
            userName.textColor = .white
            userType.textColor = .white
            view.backgroundColor = UIColor(red: 103 / 255, green: 89 / 255, blue: 1, alpha: 1)
        } else if userTypeString == "Admin" {
            userName.textColor = .white
            userType.textColor = .white
            view.backgroundColor = UIColor(red: 53 / 255, green: 41 / 255, blue: 63 / 255, alpha: 1)
        }
    }
}
