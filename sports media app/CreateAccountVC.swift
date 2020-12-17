//
//  CreateAccountVC.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/14/20.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var favTeamTF: UITextField!
    @IBOutlet weak var faveSportTF: UITextField!
    @IBAction func signUpPressed(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text, let username = userNameTF.text, let favTeam = favTeamTF.text, let favSport = faveSportTF.text, let picture = profilePic {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    Database.database().reference().child("Users").child((user?.user.uid)!).setValue(["username": username, "favoriteSport": favSport, "favoriteTeam": favTeam, "profilePicture": picture])
                }
                else {
                    print(error as Any)
                }
            }
        }
    }
    @IBAction func setProfilePicPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            profilePic.image = image
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
