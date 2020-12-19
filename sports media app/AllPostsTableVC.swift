//
//  AllPostsTableVC.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/15/20.
//

import UIKit
import Firebase

class AllPostsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [User]()
    var favSport: String? = nil
    var favTeam: String? = nil
    var username: String? = nil
    
    @IBOutlet weak var allPostsTV: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return posts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPostsCell")! as! AllPostsCellTableViewCell
        let row  = indexPath.row
        let user = posts[row]
        cell.update(with: user)
        
        return cell
    }
    
    func getPosts() {
        let ref = Database.database().reference()
        ref.child("Feed").observe(.value) { (DataSnapshot) in
            if let data1 = DataSnapshot.value as? [String:Any]{
                for datas in data1.values{
                    let moreData = datas as? [String:Any]
                    for data2 in moreData!.values {
                        let data3 = data2 as? [String:Any]
                        let uid = data3?["uid"]
                        ref.child("Users").child(uid as! String).observe(.value) { (snapshot) in
                            let value = snapshot.value as? NSDictionary
                            if let username1 = value?["username"], let favSport1 = value?["favoriteSport"], let favTeam1 = value?["favTeam"] {
                                self.username = username1 as? String
                                self.favTeam = favTeam1 as? String
                                self.favSport = favSport1 as? String
                                print(self.favSport as Any)
                                print(self.favTeam as Any)
                                print(self.username as Any)
                            }
                            else {
                                print("error assigning username again")
                            }
                        }
                        if let date = data3?["date"] as? String, let topic = data3?["topic"] as? String, let post = data3?["post"] as? String{
                            let user = User(username: self.username!, favSport: self.favSport!, favTeam: self.favTeam!, post: post, topic: topic, date: date)
                            self.posts.append(user)
                        }
                        else{
                            print("oh no")
                        }
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getPosts()
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
