//
//  MyPostsTableVC.swift
//  sports media app
//
//  Created by Grace Portch on 12/19/20.
//

import UIKit
import Firebase
class MyPostsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [User]()
    var post: String? = nil
    var topic: String? = nil
    var date: String? = nil
    
    @IBOutlet weak var myPostsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return posts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPostsCell")! as! myPostsTableViewCell
        let row  = indexPath.row
        let user = posts[row]
        cell.update(with: user)
        
        return cell
    }
    
    
    func getPostContent() -> [[String:Any]] {
        var post = [[String:Any]]()
        guard let currUid = (Auth.auth().currentUser?.uid) else {
            print("no current user?")
            return [[:]]
        }
        let ref = Database.database().reference()
        ref.child("Feed").observe(.value) { (snapshot2) in
            if let nodes = snapshot2.childSnapshot(forPath: currUid).value as? [String:Any]{
                for posts in nodes.values {
                    let dictionary = posts as? [String:Any]
                    post.append(dictionary!)
                }
            }
            else {
                print("didn't do it")
            }
        }
        return post
    }
    
    func getUserInfo() -> [String:Any] {
        var userInfo = [String:Any]()
        let ref = Database.database().reference()
        let currUid = Auth.auth().currentUser?.uid
        ref.child("Users").child(currUid!).observe(.value) { (snapshot) in
            let value = (snapshot.value as? [String:Any])!
            userInfo = value
        }
        return userInfo
    }
    
    func getPosts() {
        let postData = getPostContent()
        let userInfo = getUserInfo()
        for posts in postData {
            if let username = userInfo["username"], let favSport = userInfo["favoriteSport"], let favTeam = userInfo["favoriteTeam"],let picString = (userInfo["profilePic"]), let post = posts["post"], let topic = posts["topic"], let date = posts["date"] {
                let user = User(post: (post as? String)!, topic: (topic as? String)!, date: (date as? String)!, username: (username as? String)!, favSport: (favSport as? String)!, favTeam: (favTeam as? String)!, profilePic: picString as! String)
                self.posts.append(user)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getPosts()
       // print(posts[0])
    }
    

    
    // MARK: - Navigation

   
    

}
