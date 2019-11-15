//
//  InstructorViewsCollectionViewCell.swift
//  CourseApp
//
//  Created by Harminder on 02/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class InstructorViewsCollectionViewCell: UICollectionViewCell {
    
    //MARK::- OUTLETS

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelPosition: UILabel!
    @IBOutlet weak var imageInstructor: UIImageView!
    
    //MARK::- OVERRIDE FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
