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
    @IBAction func signUpPressed(_ sender: UIButton) {
        let imageUid = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageUid).jpeg")
        if let uploadData = profilePic.image?.jpegData(compressionQuality: 0.5) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        let picUrl = url?.absoluteString
                        self.registerUser(picture: picUrl)
                    }
                })
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
    
    
    func registerUser(picture: String?) {
        if let email = emailTF.text, let password = passwordTF.text, let username = userNameTF.text, let favTeam = favTeamTF.text, let favSport = faveSportTF.text, let picture = picture {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        Database.database().reference().child("Users").child((user?.user.uid)!).setValue(["username": username, "favoriteSport": favSport, "favoriteTeam": favTeam,"pictureURL": picture])
                    }
                else {
                    print(error as Any)
                    let alert = UIAlertController(title:"Invalid input", message: "Fill in all of the required areas please", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
        else {
            let alert = UIAlertController(title:"Invalid input", message: "Fill in all of the required areas please", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func photoToURL(profilePic: UIImage) -> URL? {
        if profilePic.jpegData(compressionQuality: 0.5) != nil {
            do {
                let filename = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                return filename
            }
            catch let error {
                print(error)
            }
        }
        return nil
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        
    @IBAction func unwindToLogInVC(segue: UIStoryboardSegue) {
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
