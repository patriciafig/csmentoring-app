//
//  HomeScreenNavigationController.swift
//  cs-mentoring
//
//  Created by Patricia on 9/24/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
import MMDrawerController

class HomeScreenNavigationController: MMDrawerController {
    var  centerContainer : MMDrawerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the right storyboard
        
        let slideOutMenuStoryBoard:UIStoryboard     =   UIStoryboard(name: "SlideOutMenu", bundle: nil)
        //set the left view controller as the slide menu
        
        let leftViewController  =   slideOutMenuStoryBoard.instantiateViewController(withIdentifier: "SlideOutMenuViewController") as! SlideOutMenuViewController
        
        //nav
        let leftSideNav     =   leftViewController
        let mainStoryBoard :UIStoryboard     =   UIStoryboard(name: "Main", bundle: nil)
        let homeVc  =   mainStoryBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        homeVc.drawerController = self
        //centering code:
        let centerNav     =   UINavigationController(rootViewController: homeVc)
        
        centerContainer =   MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav)
        centerViewController = centerContainer
        centerContainer!.openDrawerGestureModeMask  =   MMOpenDrawerGestureMode.panningCenterView
        centerContainer!.closeDrawerGestureModeMask =   MMCloseDrawerGestureMode.panningCenterView
        
        // adjust drawer width
        centerContainer?.setMaximumLeftDrawerWidth(220, animated: true, completion: nil)
        
    }
    
    func toggleDrawer(){
        centerContainer?.toggle(.left, animated: true, completion: nil)    }
    
}
