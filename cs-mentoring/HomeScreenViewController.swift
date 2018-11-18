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

//extension for user selection
extension HomeScreenViewController : UserSelectionDelegate{
    func didSelectUsers(user: UsersModel) {
        print("select")
        //self.performSegue(withIdentifier: "usersProfileSegue", sender: user)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        vc.currentUserType = user.userType
        vc.currentUserId = user.id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

enum UserType {
    case student
    case mentor
    case admin
}

class HomeScreenViewController: UIViewController, DrawerDelegate {
    
    var bioDelegate : BioDelegate?
    var interestsDelegate : InterestDelegate?
    var usersDelegate : UserProfilePictureDelegate?
    var drawerController : HomeScreenNavigationController?
    var nameHeaderDelegate: NameHeaderDelegate?
    
    var currentUserType: UserType?
    var currentUserId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawerController?.drawerDelegate = self
        
        if let currentUserType = currentUserType, let currentUserId = currentUserId {
            switch currentUserType {
            case .student:
                getStudentById(id: currentUserId)
            case .mentor:
                getMentorById(id: currentUserId)
            case .admin:
                break // TODO
            }
        } else {
            let userType =  UserDefaults.standard.string(forKey: "userType")!
            let userId = UserDefaults.standard.string(forKey: "userId")!
            print("userId", userId)
            if(userType == "Student"){
                getStudentById(id : userId)
            }else{
                getMentorById(id : userId)
            }
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
                        
                        if self.currentUserId != nil && self.currentUserType != nil {
                            self.nameHeaderDelegate?.didGetNameHeader(updatedUserType: .student, updatedUserName: json["name"].stringValue, connectedStatus: .notConnected)
                        }

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
                        var mentors = [UsersModel]()
                        if(mentorsJsonArray.count > 0){
                            for i in 0...mentorsJsonArray.count-1{
                                mentors.append(UsersModel(userType: .mentor, email: mentorsJsonArray[i]["email"].stringValue, username: mentorsJsonArray[i]["username"].stringValue, id: mentorsJsonArray[i]["_id"].stringValue, contact: mentorsJsonArray[i]["contact"].stringValue, name: mentorsJsonArray[i]["name"].stringValue))
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
                        
                        if self.currentUserId != nil && self.currentUserType != nil {
                            self.nameHeaderDelegate?.didGetNameHeader(updatedUserType: .mentor, updatedUserName: json["name"].stringValue, connectedStatus: .notConnected)
                        }
                        
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
                        var students = [UsersModel]()
                        if(studentsJsonArray.count > 0){
                            for i in 0...studentsJsonArray.count-1{
                                students.append(UsersModel(userType: .student, email: studentsJsonArray[i]["email"].stringValue, username: studentsJsonArray[i]["username"].stringValue, id: studentsJsonArray[i]["_id"].stringValue, contact: studentsJsonArray[i]["contact"].stringValue, name: studentsJsonArray[i]["name"].stringValue))
                            }
                        }
                        
                        self.usersDelegate?.didGetUsers(users: students)
                        
                        //self.usersDelegate?.didGetUsers(users: students)
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let currentUserType = currentUserType, currentUserId != nil {
            switch currentUserType {
            case .student:
                navigationItem.title = "Student Profile"
            case .mentor:
                navigationItem.title = "Mentor Profile"
            case .admin:
                navigationItem.title = "Admin Profile"
            }
        } else {
            let userTypeString = UserDefaults.standard.string(forKey: "userType") ?? "Student"
            let userName = UserDefaults.standard.string(forKey: "userFullName") ?? "No name set!"
            
            let userType: UserType = {
                if userTypeString == "Student" {
                    navigationItem.title = "Student Profile"
                    return .student
                } else if userTypeString == "Mentor" {
                    navigationItem.title = "Mentor Profile"
                    return .mentor
                } else {
                    navigationItem.title = "Admin Profile"
                    return .admin
                }
            }()
            
            nameHeaderDelegate?.didGetNameHeader(updatedUserType: userType, updatedUserName: userName, connectedStatus: .me)
        }
        
        var menu: MMDrawerController?
        var currentParent: UIViewController? = parent
        while menu == nil && currentParent != nil {
            menu = currentParent as? MMDrawerController
            currentParent = currentParent?.parent
        }
        
        if currentUserType != nil && currentUserId != nil {
            navigationItem.leftBarButtonItem = nil
            menu?.openDrawerGestureModeMask = .custom
            menu?.closeDrawerGestureModeMask = .custom
        } else {
            menu?.openDrawerGestureModeMask = .panningCenterView
            menu?.closeDrawerGestureModeMask = .panningCenterView
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let newsAndPostsFeedViewController = segue.destination as? NewsAndPostsFeedViewController {
            newsAndPostsFeedViewController.drawerController = drawerController
            newsAndPostsFeedViewController.drawerDelegate = self
        } else if let userProfilePictureViewController = segue.destination as? UserProfilePictureViewController {
            userProfilePictureViewController.userSelectionDelegate = self
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

