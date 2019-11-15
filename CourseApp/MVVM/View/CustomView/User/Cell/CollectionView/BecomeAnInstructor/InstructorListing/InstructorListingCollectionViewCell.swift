//
//  InstructorListingCollectionViewCell.swift
//  CourseApp
//
//  Created by Harminder on 02/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class InstructorListingCollectionViewCell: UICollectionViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var constraintWidthView: NSLayoutConstraint!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var constraintHeightView: NSLayoutConstraint!
    @IBOutlet weak var labelNumberOfCourses: UILabel!
    
    //MARK::- PROPERTIES
    var item :Any?{
        didSet{
            guard let instructor = item as? Instructor else { return }
            labelName?.text = /instructor.firstName + " " + /instructor.lastName
            labelNumberOfCourses?.text = /instructor.noOfCourses?.toString + " courses"
            let height = ScreenSize.SCREEN_HEIGHT/5  - 74
            constraintHeightView.constant = CGFloat(height)
            constraintWidthView.constant = CGFloat(UIScreen.main.bounds.width/1.5 )
        }
    }
    
    //MARK::- OVERRIDE FUNCTIONS
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
