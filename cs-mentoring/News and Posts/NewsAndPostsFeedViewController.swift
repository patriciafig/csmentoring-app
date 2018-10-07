//
//  NewsAndPostsFeedViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 10/6/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class NewsAndPostsFeedViewController: UIViewController, HomeScreenDelegate {
    var drawerDelegate: DrawerDelegate!
    var drawerController: HomeScreenNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News and Posts"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Hamburgericon"), style: .plain, target: self, action: #selector(openDrawer))
    }
    
    @objc func openDrawer(_ sender: UIBarButtonItem) {
        drawerController?.toggleDrawer()
    }
    
    func navigate(to item: SlideOutMenuItems) {
        drawerDelegate.navigate(to: item)
    }
}
