//
//  BioViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/31/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

//PUT: https://csmentoring.herokuapp.com/api/Students/
//PUT: https://csmentoring.herokuapp.com/api/Mentors/


protocol BioDelegate{
    func didGetBio(bio : String)
}

class BioViewController: UIViewController, BioDelegate {
    
    
    func didGetBio(bio: String) {
        print("bio")
        bioLabel.text = bio
    }
    
    @IBOutlet private var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bioLabel.textColor =  UIColor(red: 38 / 255, green: 153 / 255 , blue: 251 / 255, alpha: 1)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let homeController = self.parent else{
            return
        }
        // presented by parent view controller
        if homeController.isKind(of: HomeScreenViewController.self){
            // do something
            let vc = homeController as! HomeScreenViewController
            vc.bioDelegate = self
        }
    }
}
