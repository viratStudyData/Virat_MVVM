//
//  SubmitCourseCell.swift
//  CourseApp
//
//  Created by Apple on 05/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class SubmitCourseCell: UITableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    
    //MARK::- PROPERTIES
    let viewModel = SubmitCourseViewModel()
    var isImageRotated = false
    
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
        guard let submitCourse = data as? SubmitCourse else {return}
//        viewBG.clipsToBounds = true
//        contentView.roundCorners(submitCourse.index == 0 ? [.topLeft,.topRight] : [.bottomLeft,.bottomRight], radius: 10.0)
//        viewBG.roundCorners(submitCourse.index == 0 ? [.topLeft,.topRight] : [.bottomLeft,.bottomRight], radius: 10.0)
        labelTitle?.text = submitCourse.title
        labelTitle.textColor = submitCourse.index == 0 ? UIColor(named: "colorHeadings") : UIColor(named: "colorText")
        labelTitle.font = UIFont(name: submitCourse.index == 0 ? "Roboto-Medium" : "Roboto-Regular" , size: submitCourse.index == 0 ? labelTitle.font.pointSize :  labelTitle.font.pointSize)
        imageIcon.isHidden = submitCourse.index == 0 ? false : true
        
    }
    
}
