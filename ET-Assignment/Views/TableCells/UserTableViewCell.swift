//
//  UserTableViewCell.swift
//  ET-Assignment
//
//  Created by Sree Lakshman on 08/05/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with user: User) {
        self.nameLabel.text  = "Name - \(user.name)"
        self.emailLabel.text = "Email - \(user.email)"
        self.addressLabel.text = "Address - \(user.address.street + ", " + user.address.city)"
        self.phoneLabel.text  = "Phone - \(user.phone)"
    }
}
