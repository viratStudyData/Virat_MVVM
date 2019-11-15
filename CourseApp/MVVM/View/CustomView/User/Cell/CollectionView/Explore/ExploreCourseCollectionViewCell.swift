//
//  ExploreCourseCollectionViewCell.swift
//  CourseApp
//
//  Created by Harminder on 03/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreCourseCollectionViewCell: UICollectionViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var constraintWidthView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightView: NSLayoutConstraint!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    //MARK::- PROPERTIES
    
    var item:Any?{
        didSet{
            guard let course = item as? BestSelling else { return }
            let height = ScreenSize.SCREEN_HEIGHT/2.2 - 84
            constraintHeightView.constant = height
            constraintWidthView.constant = UIScreen.main.bounds.width/1.5
            labelPrice?.text = /course.currency + " " + /course.price?.toString
            labelPrice?.text = /course.title
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
