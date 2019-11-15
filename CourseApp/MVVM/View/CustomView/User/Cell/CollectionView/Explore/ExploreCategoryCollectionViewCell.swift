//
//  ExploreCategoryCollectionViewCell.swift
//  CourseApp
//
//  Created by Harminder on 05/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreCategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var constraintHeightImage: NSLayoutConstraint!
    @IBOutlet weak var constraintWidthImage: NSLayoutConstraint!
    
    //MARK::- PROPERTIES
    var item: Any?{
        didSet{
            guard let category = item as? Category else { return }
            let ht = ScreenSize.SCREEN_HEIGHT/8
            constraintHeightImage?.constant = ht
            constraintWidthImage?.constant = ht
            image?.cornerRadius = (ht)/2
            labelCategoryName?.text = /category.name
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
}
