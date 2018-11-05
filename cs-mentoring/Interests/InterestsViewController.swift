//
//  InterestsViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/31/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

protocol InterestDelegate {
    func didGetInterests(interests : [String])
}

extension InterestsViewController : InterestDelegate {
    func didGetInterests(interests: [String]) {
        print("interests",interests.count)
        self.interests = interests
        collectionView.reloadData()
    }
}

class InterestsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private let cellHeight: CGFloat = 40
    private var interests =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestsCell", for: indexPath) as! InterestsCollectionViewCell
        
        cell.interestLabel.text = interests[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dynamicWidth: CGFloat = cellWidth(given: interests[indexPath.row])
        return CGSize(width: dynamicWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        /*
         let height = collectionView.bounds.height
         let numberOfCells = interests.count
         
         let widthFromSpacing: CGFloat = CGFloat(interests.count - 1) * 11.0
         let cumulativeWidth: CGFloat = interests.reduce(0) { $0 + cellWidth(given: $1) } + widthFromSpacing
         
         return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
         */
        return UIEdgeInsets (top: 8, left: 0, bottom: 8, right: 0)
        
    }
    
    private func cellWidth(given text: String) -> CGFloat {
        // TODO: StackOverflow this
        
        return 104
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let homeController = self.parent else{
            return
        }
        //presented by parent view controller
        if homeController.isKind(of: HomeScreenViewController.self){
            // do something
            let vc = homeController as! HomeScreenViewController
            vc.interestsDelegate = self
            
            
        }
    }
    
}
