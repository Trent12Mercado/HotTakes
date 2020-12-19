//
//  ViewController.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 11/29/20.
//

import UIKit
import Firebase

class LogInVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    //@IBAction func createAccountPressed(_ sender: UIButton) {
    //    let createAccountPage = (self.storyboard?.instantiateViewController(identifier: "CreateAccountVC"))!
      //  self.present(createAccountPage, animated: true, completion: nil)
   // }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "goToProfile", sender: (Any).self)
                }
                else {
                    print(error as Any)
                    let alert = UIAlertController(title:"Invalid input", message: "Credentials are not correct", preferredStyle: .alert)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTF.enablesReturnKeyAutomatically = true
        passwordTF.enablesReturnKeyAutomatically = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LogInVC.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "goToProfile" {
                if let profileVC = segue.destination as? AccountDetailViewController {
                    if let currUserID = Auth.auth().currentUser?.uid {
                        profileVC.currUid = currUserID
                        print(currUserID)
                    }
                    else {
                        print("something went wrong")
                        return
                    }
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        


}

