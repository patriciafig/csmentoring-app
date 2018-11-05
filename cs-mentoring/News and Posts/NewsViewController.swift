//
//  NewsViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 10/14/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    weak var delegate: NewsFeedDelegate?
    
    var newsFeed = [NewsFeed]()
    
    //    private let fakeData = Array(repeating: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim.", count: 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getNewsFeedFromApi()
        
    }
    
    func getNewsFeedFromApi(){
        let headersInfo = [
            "content-type": "application/json",
            ]
    
        Alamofire.request(Endpoints.postsUrl,
                          method: .get,
                          headers: headersInfo)
            
            .validate().responseJSON{
                response in switch response.result{
                    
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        if(json.count > 0){
                            for i in 0...json.count-1{
                                let newsFeed = NewsFeed.init(id: json[i]["_id"].stringValue, postTime:  json[i]["postTime"].stringValue, description:  json[i]["description"].stringValue, title:  json[i]["title"].stringValue, postedBy:  json[i]["postedBy"].stringValue)
                                self.newsFeed.append(newsFeed)
                            }
                        }
                        
                        self.collectionView.reloadData()
                        
                    }
                    
                    break
                    
                case .failure(let error):
                    
                    
                    print(error)
                    
                    
                    break
                    
                }
                
        }// Alamofire end
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
        cell.newsFeed = self.newsFeed[indexPath.row]
        //        cell.descriptionLabel.text = fakeData[indexPath.row]
        //        cell.timestampLabel.text = "1h ago"
        
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
