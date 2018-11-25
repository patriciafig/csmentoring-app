//
//  UserProfileViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 11/15/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


protocol UserProfileDelegate {
    func connectBtnDidTapped()
}

extension UserProfileViewController : UserProfileDelegate{
    func connectBtnDidTapped() {
        let alert = UIAlertController(title: "Connect with Mentor", message: "How would you like to connect with Rachel?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Message", style: .default, handler: { action in
            
            switch action.style{
            case .default:
                let vc = UIStoryboard(name: "ConversationsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ConversationsViewController") as! ConversationsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
                
            }}))
        alert.addAction(UIAlertAction(title: "Schedule", style: .default, handler: { action in
            
            switch action.style{
            case .default:
                print("default")
                let vc = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

class UserProfileViewController: UIViewController {
    
    var bioDelegate : BioDelegate?
    var interestsDelegate : InterestDelegate?
    var usersDelegate : UserProfilePictureDelegate?
    var user : UsersModel?
    var profileHeaderDelegate : ProfileDetailsHeaderDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        guard let user = user else {return}
        let userId = user.id
        let userType =  UserDefaults.standard.string(forKey: "userType")!
        print(user)
        if(userType == "Student"){
            getMentorById(id : userId)
            profileHeaderDelegate?.didGetDetails(name: user.name, post: "Mentor")
            
        }else{
            getStudentById(id : userId)
            profileHeaderDelegate?.didGetDetails(name: user.name, post: "Student")
            
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
                        var mentors = [UsersModel]()
                        if(mentorsJsonArray.count > 0){
                            for i in 0...mentorsJsonArray.count-1{
                                mentors.append(UsersModel.init(email: mentorsJsonArray[i]["email"].stringValue, username: mentorsJsonArray[i]["username"].stringValue, id: mentorsJsonArray[i]["_id"].stringValue, contact: mentorsJsonArray[i]["contact"].stringValue, name: mentorsJsonArray[i]["name"].stringValue))
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
                        var students = [UsersModel]()
                        if(studentsJsonArray.count > 0){
                            for i in 0...studentsJsonArray.count-1{
                                students.append(UsersModel.init(email: studentsJsonArray[i]["email"].stringValue, username: studentsJsonArray[i]["username"].stringValue, id: studentsJsonArray[i]["_id"].stringValue, contact: studentsJsonArray[i]["contact"].stringValue, name: studentsJsonArray[i]["name"].stringValue))
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileHeaderVc = segue.destination as? ProfileDetailsHeaderViewController{
            profileHeaderVc.profileDelegate = self
        }
    }
    
    
    
}


