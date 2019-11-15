//
//  InstHomeTableCell.swift
//  CourseApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class InstHomeTableCell: UITableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageLeading: UIImageView!
    @IBOutlet weak var labelCount: UIButton!
    @IBOutlet weak var viewBG: UIView!
    //MARK::- PROPERTIES
    var data: Any?{
        didSet{
            configureControls()
        }
    }
    
    var isConfigureCell: Bool?{
        didSet{
            if !(/isConfigureCell) { return }
            contentView.roundCorners(/(data as? InstHome)?.index == 0 ? [.topLeft,.topRight] : [.bottomLeft,.bottomRight] , radius: 10)
        }
    }
    
    //MARK::- OVERRIDE FUNCTIONS
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK::- FUNCTIONS
    func configureControls() {
        guard let instHome = data as? InstHome else {return}
        imageLeading?.image = instHome.icon
        labelTitle?.text = instHome.title
        labelDesc?.text = instHome.desc
        labelCount?.backgroundColor = instHome.color
        viewBG.backgroundColor = instHome.index == 0 ? R.color.colorCreateCourse() : .white
        labelTitle.textColor =  instHome.index == 0 ? .white : R.color.colorHeadings()
        labelDesc.textColor =  instHome.index == 0 ? .white : .systemGray
        labelCount.isHidden = instHome.index == 0 ? true : false
    }
    
    
}
