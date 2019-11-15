//
//  CourseObjectiveCell.swift
//  CourseApp
//
//  Created by Apple on 13/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseObjectiveCell: BaseTableViewCell {
    
    
    //MARK::- OUTLETS
    @IBOutlet weak var textfieldAns: UITextField!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    
     
    
    //MARK::- PROPERTIES
    var heightBlock : ((_ increase : Bool) -> ())?
    
    var item: Any?{
        didSet{
           // labelTitle?.text = /(item as? Questions)?.title
            configureTableView()
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
    
    //MARK: - CONFIGURE TABLEVIEW

   func configureTableView() {
    
    }
}
