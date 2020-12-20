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
    var profilePic: String
    var post: String
    var topic: String
    var date: String
    
    init(post: String, topic: String, date: String, username: String, favSport: String, favTeam: String, profilePic: String) {
        self.post = post
        self.topic = topic
        self.date = date
        self.username = username
        self.favTeam = favTeam
        self.favSport = favSport
        self.profilePic = profilePic
    }
    
    
    
    
    
    
    
    
    
}
