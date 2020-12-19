//
//  CreatePostVC.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/15/20.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {

    @IBOutlet weak var topicTF: UITextField!
    @IBOutlet weak var postTF: UITextField!
    let date = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusPressed(_ sender: UIBarButtonItem) {
        if let post = postTF.text, let topic = topicTF.text {
            Database.database().reference().child("Feed").child(Auth.auth().currentUser!.uid).childByAutoId().setValue(["post": post, "date" :date, "topic": topic, "uid": Auth.auth().currentUser!.uid])
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
