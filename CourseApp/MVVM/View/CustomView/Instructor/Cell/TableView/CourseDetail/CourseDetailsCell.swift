//
//  CourseDetailsCell.swift
//  CourseApp
//
//  Created by Apple on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseDetailsCell: UITableViewCell {
    
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    //MARK::- PROPERTIES
    
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
        guard let courseDetail = data as? CourseDetails else {return}
        labelTitle?.text = courseDetail.title
        textField?.placeholder = courseDetail.title
        
    }
}
