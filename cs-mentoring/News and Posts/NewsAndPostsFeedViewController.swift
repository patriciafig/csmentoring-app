//
//  NewsAndPostsFeedViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 10/6/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

protocol NewsFeedDelegate: class {
    func newsFeedDidUpdate(contentSize: CGSize)
}

class NewsAndPostsFeedViewController: UIViewController, HomeScreenDelegate, NewsFeedDelegate {
    var drawerDelegate: DrawerDelegate!
    var drawerController: HomeScreenNavigationController?
    
    
    @IBOutlet private var middleConstraint: NSLayoutConstraint!
    @IBOutlet private var topConstraint: NSLayoutConstraint!
    @IBOutlet private var postsHeight: NSLayoutConstraint!
    @IBOutlet private var newsFeedHeight: NSLayoutConstraint!
    @IBOutlet private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News and Posts"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Hamburgericon"), style: .plain, target: self, action: #selector(openDrawer))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let newsFeedViewController = segue.destination as? NewsViewController {
            newsFeedViewController.delegate = self
        }
    }
    
    @objc func openDrawer(_ sender: UIBarButtonItem) {
        drawerController?.toggleDrawer()
    }
    
    func navigate(to item: SlideOutMenuItems) {
        drawerDelegate.navigate(to: item)
    }
    
    func newsFeedDidUpdate(contentSize: CGSize) {
        newsFeedHeight.constant = contentSize.height + 16
        view.layoutIfNeeded()
        
        let scrollViewHeight = contentSize.height + postsHeight.constant + topConstraint.constant + middleConstraint.constant + 16
        scrollView.contentSize = CGSize(width: view.bounds.width, height: scrollViewHeight)
    }
}
