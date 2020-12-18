//
//  AccountDetailViewController.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/15/20.
//

import UIKit
import Firebase

class AccountDetailViewController: UIViewController {
    
    var currUid: String? = nil
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var favoriteSportLab: UILabel!
    @IBOutlet weak var favoriteTeamLab: UILabel!
    @IBOutlet weak var usernameLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let currUser = Auth.auth().currentUser {
            let ref = Database.database().reference()
            ref.child(currUid!).observe(.value) { [self] (DataSnapshot) in
                let data = DataSnapshot.value as? [String: Any]
                if let favTeam = data?["favoriteTeam"], let favSport = data?["favoriteSport"], let username = data?["username"] {
                    self.favoriteSportLab.text = favSport as? String
                    favoriteTeamLab.text = favTeam as? String
                    usernameLab.text = username as? String
                }
            }
        }
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
