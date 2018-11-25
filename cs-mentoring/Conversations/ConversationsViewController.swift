//
//  ConversationsViewController.swift
//
//  Created by Patricia on 11/17/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.

import UIKit

class ConversationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saySomethingTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        hideKeyboardWhenTappedAround()
        saySomethingTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Conversation with Mentor"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.RoyalPurple]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func setupTableView(){
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
}


extension ConversationsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 5){
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! DateTableViewCell
            return cell
        }
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstPersonCell") as! FirstPersonTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondPersonCell") as! MentorTableViewCell
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.mDismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func mDismissKeyboard() {
        view.endEditing(true)
    }
}
