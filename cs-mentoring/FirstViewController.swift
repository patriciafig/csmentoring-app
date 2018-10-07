//
//  FirstViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 10/6/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
