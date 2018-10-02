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

class BioViewController: UIViewController {
    
    @IBOutlet private var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bioLabel.textColor =  UIColor(red: 38 / 255, green: 153 / 255 , blue: 251 / 255, alpha: 1)
    }
}
