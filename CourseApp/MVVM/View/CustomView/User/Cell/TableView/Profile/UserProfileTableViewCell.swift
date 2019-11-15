//
//  UserProfileTableViewCell.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 29/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    //MARK::- OUTLETS
    
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageProfileIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    //MARK::- PROPERTIES
    var profile: Any?{
        didSet{
            guard let element  = profile as? UserProfileElements else{
                return
            }
            labelTitle?.text = /element.title
            labelDesc?.text = /element.desc
            imageProfileIcon?.image = element.icon
        }
    }
    
    //MARK::- OVERRIDE FUNCTIONS

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
