//
//  User.swift
//  TwitterClone2
//
//  Created by Lindsey on 6/13/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import Foundation

class User{
    let name:String
    let profileImageURL:String
    let location:String
    
    init? (json: [String:AnyObject]){
        if let name = json["name"] as? String, profileImageURL = json["profile_image_url"] as? String, location = json["location"] as? String {
            self.name = name
            self.profileImageURL = profileImageURL
            self.location = location
        }else{
            return nil
        }
    }
}