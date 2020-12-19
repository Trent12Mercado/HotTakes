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
    var post: String
    var topic: String
    var date: String
    init(username: String, favSport: String, favTeam: String, post: String, topic: String, date: String) {
        self.username = username
        self.favSport = favSport
        self.favTeam = favTeam
        self.post = post
        self.topic = topic
        self.date = date
        //self.profilePic = profilePic
    }
    
    
    
    
}
