//
//  UserProfilePictureViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 9/7/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

protocol UserProfilePictureDelegate {
    func didGetUsers(users : [String])
}

class UserProfilePictureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var headerLabel: UILabel!
    
    // private let userProfilePicture = Array(repeating: UIImage(named: "UserIcon"),     count: 10) + [UIImage(named:"circleicon")]
    
    private var names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let userTypeString = UserDefaults.standard.string(forKey: "userType")
        
        if userTypeString == "Student" || userTypeString == "Admin" {
            headerLabel.text = "MENTORS"
        } else {
            headerLabel.text = "STUDENTS"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfilePictureCollectionViewCell", for: indexPath) as! UserProfilePictureCollectionViewCell
        
        // cell.profilePic.image = userProfilePicture[indexPath.row]
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let homeController = self.parent else{
            return
        }
        //presented by parent view controller
        if homeController.isKind(of: HomeScreenViewController.self){
            // do something
            let vc = homeController as! HomeScreenViewController
            vc.usersDelegate = self
            
            
        }
    }
}

extension UserProfilePictureViewController : UserProfilePictureDelegate {
    func didGetUsers(users: [String]) {
        self.names = users
        collectionView.reloadData()
    }
    
    
    
    
}
