//
//  SlideOutMenuViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 9/9/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

//test model class for list in slideout menu
struct SlideOutMenuItems {
    var menuIcon : UIImage
    var menuLabel : String
    
    init(menuIcon : UIImage, menuLabel : String) {
        self.menuIcon = menuIcon
        self.menuLabel = menuLabel
        
    }
}

protocol DrawerDelegate: class {
    func navigate(to item: SlideOutMenuItems?)
}

class SlideOutMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var menuItems = [SlideOutMenuItems]()
    @IBOutlet weak var tableView: UITableView!
    let cellId = "menuCell"
    
    weak var drawerDelegate: DrawerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        // add items to list
        
        for i in 0...5{
            menuItems.append(SlideOutMenuItems(menuIcon: #imageLiteral(resourceName: "Feedicon"), menuLabel: "NEWS \(i)"))
            
            //TODO: this is where we add the items for the menu
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let nameHeaderViewController = segue.destination as? NameHeaderViewController {
            nameHeaderViewController.hidesEditButton = true
            nameHeaderViewController.enableProfileButton = true
            nameHeaderViewController.drawerDelegate = drawerDelegate
            nameHeaderViewController.drawerController = drawerDelegate as? HomeScreenNavigationController
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TODO: handle what happens when user taps a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SlideOutMenuTableViewCell
        cell.menuItem = self.menuItems[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            drawerDelegate.navigate(to: menuItems[indexPath.row])
        }
    }
    
    
    
}


