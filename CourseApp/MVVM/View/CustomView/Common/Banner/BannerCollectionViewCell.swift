//
//  BannerCollectionViewCell.swift
//  CourseApp
//
//  Created by Harminder on 02/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    //MARK::- OUTLETS
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelImage: UIImageView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var labelSubheading: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    
    //MARK::- PROPERTIES
    var item: Any?{
        didSet{
            guard let banner = item as? Banner else { return }
            labelHeading?.text = banner.bannerName
        }
    }
    
    
    //MARK::- FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
