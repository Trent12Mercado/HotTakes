//
//  AccountDetailViewController.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/15/20.
//

import UIKit
import Firebase

class AccountDetailViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var favoriteSportLab: UILabel!
    @IBOutlet weak var favoriteTeamLab: UILabel!
    @IBOutlet weak var usernameLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let currUid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(currUid!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            print(value as Any)
            if let username = value?["username"] as? String, let favSport = value?["favoriteSport"] as? String, let favTeam = value?["favoriteTeam"] as? String, let picString = value?["profilePic"] as? String {
                self.favoriteTeamLab.text = favTeam
                self.favoriteSportLab.text = favSport
                self.usernameLab.text = username
                let url = URL(string: picString)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    DispatchQueue.main.async {
                        self.profilePic.image = UIImage(data: data!)
                    }
                })
                task.resume()
            }
            else {
                print("it went wrong")
            }
        })
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
