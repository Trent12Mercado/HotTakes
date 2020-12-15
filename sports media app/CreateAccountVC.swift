//
//  CreateAccountVC.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/14/20.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordLab: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordLab: UILabel!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBAction func signUpPressed(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text, let username = userNameTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    Database.database().reference().child("Users").child((user?.user.uid)!).setValue(username)
                }
                else {
                    print(error as Any)
                }
            }
        }
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
