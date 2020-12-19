//
//  Feed.swift
//  sports media app
//
//  Created by Grace Portch on 12/18/20.
//

import Foundation
  

class Feed {
    var post: String
    var date: String
    var topic: String
    
    init(post: String, date: String, topic: String) {
        self.post = post
        self.date = date
        self.topic = topic
    }
}
