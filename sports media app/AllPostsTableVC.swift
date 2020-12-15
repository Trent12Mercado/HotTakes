//
//  AllPostsTableVC.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/15/20.
//

import UIKit
import Firebase

class AllPostsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var allPostsTV: UITableView!
    var dates = [String]()
    var posts = [String]()
    var topics = [String]()
    var profilePics = [UIImageView]()
    var usernames = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPostsCell")! as! AllPostsCellTableViewCell
        cell.profilePic = profilePics[indexPath.row]
        cell.postContent.text = posts[indexPath.row]
        cell.dateLab.text = dates[indexPath.row]
        cell.usernameLab.text = usernames[indexPath.row]
        cell.topicLab.text = topics[indexPath.row]
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Database.database().reference().child("Feed").observe(.value) { (DataSnapshot) in
            if let data1 = DataSnapshot.value as? [String:Any]{
                for datas in data1.values{
                    let moreData = datas as? [String:Any]
                    for data2 in moreData!.values {
                        let data3 = data2 as? [String:Any]
                        self.dates.append(data3!["date"] as! String)
                        self.posts.append(data3!["post"] as! String)
                        self.topics.append(data3!["topics"] as! String)
                    }
                }
            }
        }
        Database.database().reference().child("Users").observe(.value) { (DataSnapshot) in
            if let data4 = DataSnapshot.value as? [String:Any]{
                for data5 in data4.values{
                    let data6 = data5 as? [String:Any]
                    for data8 in data6!.values {
                        let data9 = data8 as? [String:Any]
                        self.profilePics.append(data9!["profilePictures"] as! UIImageView)
                        self.usernames.append(data9!["username"] as! String)
                    }
                }
            }
        }
        DispatchQueue.main.async(execute: {
            self.allPostsTV.reloadData()
        })
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
