//
//  NameHeaderViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/21/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

protocol NameHeaderDelegate: class {
    func didGetNameHeader(updatedUserType: UserType, updatedUserName: String, connectedStatus: ConnectedStatus)
}

enum ConnectedStatus {
    case notConnected
    case connected
    case me
}
 
class NameHeaderViewController: UIViewController, HomeScreenDelegate, NameHeaderDelegate {
    var drawerController: HomeScreenNavigationController?
    var drawerDelegate: DrawerDelegate!
    
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var userType: UILabel!
    @IBOutlet private var editButton: UIButton!
    @IBOutlet private var editButtonWidth: NSLayoutConstraint!
    @IBOutlet private var profileIconWidth: NSLayoutConstraint!
    
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
    
    func didGetNameHeader(updatedUserType: UserType, updatedUserName: String, connectedStatus: ConnectedStatus) {
        let userTypeString: String
        switch updatedUserType {
        case .student:
            userTypeString = "Student"
        case .mentor:
            userTypeString = "Mentor"
        case .admin:
            userTypeString = "Admin"
        }
        
        userName.text = updatedUserName
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
        
        switch connectedStatus {
        case .notConnected, .connected:
            profileIconWidth.constant = 0
            editButtonWidth.constant = 96
            editButton.setImage(nil, for: .normal)
            editButton.backgroundColor = UIColor.init(red: 90 / 255, green: 225 / 255, blue: 252 / 255, alpha: 1)
            editButton.setTitle("CONNECT", for: .normal)
            editButton.addTarget(self, action: #selector(handleConnect), for: .primaryActionTriggered)
        case .me:
            profileIconWidth.constant = 40
        }
    }
    
    @objc func handleConnect(_ sender: Any) {
        let alert = UIAlertController(title: "How would you like to connect with \(userName.text ?? String(""))?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Message", style: .default, handler: { _ in
            guard let vc = UIStoryboard(name: "ConversationsStoryboard", bundle: nil).instantiateInitialViewController() else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Schedule", style: .default, handler: { _ in
            // TODO
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        editButton.isHidden = hidesEditButton
        
        guard let homeController = self.parent else{
            return
        }
        //presented by parent view controller
        if homeController.isKind(of: HomeScreenViewController.self) {
            // do something
            let vc = homeController as! HomeScreenViewController
            vc.nameHeaderDelegate = self
        } else if homeController.isKind(of: SlideOutMenuViewController.self) {
            let vc = homeController as! SlideOutMenuViewController
            vc.nameHeaderDelegate = self
        }
    }
}
