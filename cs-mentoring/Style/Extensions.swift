//
//  Extensions.swift
//  cs-mentoring
//
//  Created by Patricia on 9/4/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

extension UIColor {
    // Represents the SeaBlue #5AE1FC, with RGB values of (90, 255, 252
    static var SeaBlue: UIColor {
        get {
            return UIColor(red: 90.0/255.0, green: 255.0/255.0, blue: 252.0/255.0, alpha:1)
        }
    }
    
    // Represents the color CloudBlue #F1F9FF
    static var CloudBlue: UIColor {
        get{
            return UIColor(red: 241.0/255.0, green: 249.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    // Represents the color SkyBlue #2699FB, whose RGB values are (38, 153, 251)
    static var SkyBlue: UIColor {
        get {
            return UIColor(red: 38.0/255.0, green: 153.0/255.0, blue: 251.0/255.0, alpha:1)
        }
    }
    
    // Represents the color RoyalPurple #6759FF, whose RGB values are (103, 89, 255)
    // MENTOR
    static var RoyalPurple: UIColor {
        get {
            return UIColor(red: 103.0/255.0, green: 89.0/255, blue: 255.0/255.0, alpha: 1)
        }
    }
    //Represents the color PlumPurple #35293F, whose RGB values are (53, 41, 63)
    static var PlumPurple: UIColor {
        get {
            return UIColor(red: 53.0/255, green: 41.0/255.0, blue: 63.0/255.0, alpha: 1)
        }
        
    }
    //Represents the color BrightYellow #F4DA1C, whose RGB values are (244, 218, 28)
    static var BrightYellow: UIColor {
        get{
            return UIColor(red: 244.0/255, green: 218.0/255, blue: 28.0/255.0, alpha: 1)
        }
    }
}



