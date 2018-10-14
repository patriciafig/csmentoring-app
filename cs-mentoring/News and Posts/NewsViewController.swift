//
//  NewsViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 10/14/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    weak var delegate: NewsFeedDelegate?
    
    private let fakeData = Array(repeating: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim.", count: 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fakeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
        
        cell.descriptionLabel.text = fakeData[indexPath.row]
        cell.timestampLabel.text = "1h ago"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.newsFeedDidUpdate(contentSize: collectionView.contentSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // segue to post detail view controller
    }
}
