//
//  HomeScreenViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/21/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
import MMDrawerController

protocol HomeScreenDelegate {
    var drawerController: HomeScreenNavigationController? { get set }
    var drawerDelegate: DrawerDelegate! { get set }
}

class HomeScreenViewController: UIViewController, DrawerDelegate {
    
    
    var drawerController : HomeScreenNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerController?.drawerDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "\(UserDefaults.standard.string(forKey: "userType")!) Profile"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let newsAndPostsFeedViewController = segue.destination as? NewsAndPostsFeedViewController {
            newsAndPostsFeedViewController.drawerController = drawerController
            newsAndPostsFeedViewController.drawerDelegate = self
        }
    }
    
    @IBAction func hamburgerButtonTapped(_ sender: Any) {
        print("tapped")
        drawerController?.toggleDrawer()
    }
    
    func navigate(to item: SlideOutMenuItems?) {
        if let item = item {
            if item.menuLabel == "NEWS 0" {
                performSegue(withIdentifier: "posts", sender: nil)
                drawerController?.toggleDrawer()
            }
        } else {
            navigationController?.popViewController(animated: false)
        }
    }
}

