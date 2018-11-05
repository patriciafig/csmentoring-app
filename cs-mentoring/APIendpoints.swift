//
//  APIendpoints.swift
//  cs-mentoring
//
//  Created by Patricia on 10/29/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

let baseUrl = "https://csmentoring.herokuapp.com"

struct Endpoints{
    public  static let postsUrl =  baseUrl + "/api/posts"
    public  static let getAllMentors =  baseUrl + "/api/mentors"
    public  static let getAllStrudent =  baseUrl + "/api/students"
    
    public static let getStudentById = baseUrl + "/api/student/"
    public static let getMentorById = baseUrl + "/api/mentor/"
}
