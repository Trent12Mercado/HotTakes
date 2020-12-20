//
//  AllPostsCellTableViewCell.swift
//  sports media app
//
//  Created by Mercado, Trenton Laurent on 12/15/20.
//

import UIKit

class AllPostsCellTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var topicLab: UILabel!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var dateLab: UILabel!
    @IBOutlet weak var usernameLab: UILabel!
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with user: User) {
        print(user.date)
        topicLab.text = user.topic
        postContent.text = user.post
        dateLab.text = user.date
        usernameLab.text = user.username
        if let image = URL(string: user.profilePic) {
            URLSession.shared.dataTask(with: image) { (data, response, error) in
                if error != nil {
                    print("we got an error")
                    return
                }
                self.profilePic.image = UIImage(data: data!)
            }
        }
    }

}
