//
//  ProfileCell.swift
//  CourseApp
//
//  Created by Apple on 04/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    
    //MARK::- PROPERTIES
    let viewModel = ProfileViewModel()
    
    var data: Any?{
        didSet{
          configureControls()
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
    
    
    //MARK::- FUNCTIONS
    func configureControls() {
        guard let profile = data as? Profile else {return}
        imageIcon?.image = profile.icon
        labelTitle?.text = profile.title
       }
    
}
