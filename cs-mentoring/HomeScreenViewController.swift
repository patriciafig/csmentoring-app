//
//  HomeScreenViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/21/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
import MMDrawerController
class HomeScreenViewController: UIViewController {
    var drawerController : HomeScreenNavigationController?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "\(UserDefaults.standard.string(forKey: "userType")!) Profile"
        
    }
    @IBAction func hamburgerButtonTapped(_ sender: Any) {
        print("tapped")
        drawerController?.toggleDrawer()
        }
    }

