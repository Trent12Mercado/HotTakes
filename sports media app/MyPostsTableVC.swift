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
    var favSport: String? = nil
    var favTeam: String? = nil
    var username: String? = nil
    
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
    
    func getPosts() {
        guard let currUid = (Auth.auth().currentUser?.uid) else {
            print("no current user?")
            return
        }
        let ref = Database.database().reference()
        ref.child("Users").child(currUid).observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.username = (value!["username"] as! String)
            self.favSport = value!["favoriteSport"] as? String
            self.favTeam = (value!["favoriteTeam"] as! String)
        }
        ref.child("Feed").observe(.value) { (snapshot2) in
            if let userUid = snapshot2.childSnapshot(forPath: currUid).value as? [String:Any]{
                for posts in userUid {
                    let value = (posts as AnyObject).value
                    if let post = value["post"], let date = value["date"], let topic = value["topic"] {
                        let user = User(username: self.username, favSport: self.favSport, favTeam: self.favTeam, post: post, topic: topic, date: date)
                    }
                }
            }
            else {
                print("didn't do it")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getPosts()
       // print(posts[0])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
