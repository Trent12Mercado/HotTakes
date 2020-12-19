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
        Database.database().reference().child("Users").child(currUid!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.favoriteTeamLab.text = value?["favoriteTeam"] as? String
            self.favoriteSportLab.text = value?["favoriteSport"] as? String
            self.usernameLab.text = value?["username"] as? String
        })
        { (Error) in print(Error.localizedDescription)}
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
