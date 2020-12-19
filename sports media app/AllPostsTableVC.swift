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
        cell.postContent.text = posts[row].post
        cell.dateLab.text = posts[row].date
        cell.usernameLab.text = posts[row].username
        cell.topicLab.text = posts[row].topic
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ref = Database.database().reference()
        ref.child("Feed").observe(.value) { (DataSnapshot) in
            if let data1 = DataSnapshot.value as? [String:Any]{
                for datas in data1.values{
                    let moreData = datas as? [String:Any]
                    for data2 in moreData!.values {
                        let data3 = data2 as? [String:Any]
                        
                        
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
