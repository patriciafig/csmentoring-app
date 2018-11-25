//
//  ProfileDetailsHeaderViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 11/15/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

protocol ProfileDetailsHeaderDelegate {
    func didGetDetails(name : String, post : String)
}

extension ProfileDetailsHeaderViewController  : ProfileDetailsHeaderDelegate{
    func didGetDetails(name: String, post: String) {
        self.nameLabel.text = name
        self.userTypeLabel.text = post
    }
}

class ProfileDetailsHeaderViewController: UIViewController {
    
    var profileDelegate : UserProfileDelegate?
    
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func connectBtnTapped(_ sender: Any) {
        profileDelegate?.connectBtnDidTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let homeController = self.parent else{
            return
        }
        if(homeController.isKind(of: UserProfileViewController.self)){
            let vc = homeController as! UserProfileViewController
            vc.profileHeaderDelegate = self
        }
    }
    
    
    
    
    
}
