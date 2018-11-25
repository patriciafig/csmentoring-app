//
//  ScheduleViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 11/20/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Schedule a Meeting"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        let backImage = UIImage(named: "icons8-left_filled")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        //        self.navigationItem.leftBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
