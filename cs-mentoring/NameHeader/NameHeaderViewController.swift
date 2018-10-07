//
//  NameHeaderViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/21/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
 
class NameHeaderViewController: UIViewController, HomeScreenDelegate {
    var drawerController: HomeScreenNavigationController?
    var drawerDelegate: DrawerDelegate!
    
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var userType: UILabel!
    @IBOutlet private var editButton: UIButton!
    
    var hidesEditButton: Bool = false
    var enableProfileButton: Bool = false
    
    @IBAction private func editButtonTapped(_ sender: UIButton) {
        // TODO: Edit Profile Button
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        if enableProfileButton {
            drawerController?.toggleDrawer()
            drawerDelegate.navigate(to: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userTypeString = UserDefaults.standard.string(forKey: "userType")
        
        userName.text = UserDefaults.standard.string(forKey: "userFullName") ?? "No name set!"
        userType.text = userTypeString
        
        if userTypeString == "Student" {
            userName.textColor = UIColor.SkyBlue
            userType.textColor = UIColor.SkyBlue
            view.backgroundColor = UIColor.CloudBlue
        } else if userTypeString == "Mentor" {
            userName.textColor = .white
            userType.textColor = .white
            view.backgroundColor = UIColor.RoyalPurple
        } else if userTypeString == "Admin" {
            userName.textColor = .white
            userType.textColor = .white
            view.backgroundColor = UIColor.PlumPurple
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        editButton.isHidden = hidesEditButton
    }
}
