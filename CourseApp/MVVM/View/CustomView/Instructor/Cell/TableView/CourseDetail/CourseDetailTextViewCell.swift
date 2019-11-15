//
//  CourseDetailTextViewCell.swift
//  CourseApp
//
//  Created by Apple on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseDetailTextViewCell: UITableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    //MARK::- PROPERTIES
    
    //MARK::- PROPERTIES
    
    var data: Any?{
        didSet{
            configureControls()
        }
    }
    
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
        textView?.text = courseDetail.title
        
    }
}
