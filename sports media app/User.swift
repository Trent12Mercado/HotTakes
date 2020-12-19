//
//  User.swift
//  sports media app
//
//  Created by Grace Portch on 12/17/20.
//

import Foundation
import Firebase

class User {
    var username: String
    var favSport: String
    var favTeam: String
    var profilePic: String? = nil
    var post: String? = nil
    var topic: String? = nil
    var date: String? = nil
    init(username: String, favSport: String, favTeam: String /*profilePic: String*/) {
        self.username = username
        self.favSport = favSport
        self.favTeam = favTeam
        //self.profilePic = profilePic
    }
    
    
    
    
}
