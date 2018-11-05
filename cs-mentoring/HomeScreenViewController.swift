//
//  HomeScreenViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 8/21/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON

protocol HomeScreenDelegate {
    var drawerController: HomeScreenNavigationController? { get set }
    var drawerDelegate: DrawerDelegate! { get set }
}


class HomeScreenViewController: UIViewController, DrawerDelegate {
    
    var bioDelegate : BioDelegate?
    var interestsDelegate : InterestDelegate?
    var usersDelegate : UserProfilePictureDelegate?
    var drawerController : HomeScreenNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerController?.drawerDelegate = self
        
        let userType =  UserDefaults.standard.string(forKey: "userType")!
        let userId = UserDefaults.standard.string(forKey: "userId")!
        print("userId", userId)
        if(userType == "Student"){
            getStudentById(id : userId)
        }else{
            getMentorById(id : userId)
        }
    }
    
    
    func getStudentById(id : String){
        let headersInfo = [
            "content-type": "application/json",
            ]
        Alamofire.request(Endpoints.getStudentById + id,
                          method: .get,
                          headers: headersInfo)
            
            .validate().responseJSON{
                response in switch response.result{
                    
                case .success:
                    
                    if let value = response.result.value{
                        let json = JSON(value)
                        
                        //for bio section
                        self.bioDelegate?.didGetBio(bio: json["about"].stringValue)
                        
                        //for interest section
                        let interestsJsonArray = json["interests"]
                        var interests = [String]()
                        if(interestsJsonArray.count > 0){
                            for i in 0...interestsJsonArray.count-1{
                                interests.append(interestsJsonArray[i].stringValue)
                            }
                        }
                        
                        //for mentors section
                        let mentorsJsonArray = json["mentors"]
                        var mentors = [String]()
                        if(mentorsJsonArray.count > 0){
                            for i in 0...mentorsJsonArray.count-1{
                                mentors.append(mentorsJsonArray[i].stringValue)
                            }
                        }
                        
                        self.usersDelegate?.didGetUsers(users: mentors)
                        self.interestsDelegate?.didGetInterests(interests: interests)
                        print(json)
                    }
                    
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                    
                }
                
        }
    }
    
    func getMentorById(id : String){
        let headersInfo = [
            "content-type": "application/json",
            ]
        
        Alamofire.request(Endpoints.getMentorById + id,
                          method: .get,
                          headers: headersInfo)
            
            .validate().responseJSON{
                response in switch response.result{
                    
                case .success:
                    if let value = response.result.value{
                        let json = JSON(value)
                        
                        //for bio section
                        self.bioDelegate?.didGetBio(bio: json["about"].stringValue)
                        
                        //for interest section
                        let interestsJsonArray = json["interests"]
                        var interests = [String]()
                        if(interestsJsonArray.count > 0){
                            for i in 0...interestsJsonArray.count-1{
                                interests.append(interestsJsonArray[i].stringValue)
                            }
                        }
                        
                        //for students section
                        let studentsJsonArray = json["students"]
                        var students = [String]()
                        if(studentsJsonArray.count > 0){
                            for i in 0...studentsJsonArray.count-1{
                                students.append(studentsJsonArray[i].stringValue)
                            }
                        }
                        
                        self.usersDelegate?.didGetUsers(users: students)
                        self.interestsDelegate?.didGetInterests(interests: interests)
                        print(json)
                    }
                    
                    break
                    
                    
                    
                case .failure(let error):
                    print(error)
                    break
                    
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(UserDefaults.standard.string(forKey: "userType")!) Profile"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let newsAndPostsFeedViewController = segue.destination as? NewsAndPostsFeedViewController {
            newsAndPostsFeedViewController.drawerController = drawerController
            newsAndPostsFeedViewController.drawerDelegate = self
        }
        
    
    }
    
    @IBAction func hamburgerButtonTapped(_ sender: Any) {
        print("tapped")
        drawerController?.toggleDrawer()
    }
    
    func navigate(to item: SlideOutMenuItems?) {
        if let item = item {
            if item.menuLabel == "NEWS 0" {
                performSegue(withIdentifier: "posts", sender: nil)
                drawerController?.toggleDrawer()
            }
        } else {
            navigationController?.popViewController(animated: false)
        }
    }
}

