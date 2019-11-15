//
//  HomeHeaderView.swift
//  NequoreUser
//
//  Created by cbl24_Mac_mini on 10/07/18.
//

import UIKit

protocol HomeHeaderDelegate : class {
    func showDetails(tag:Int?)
}

class HomeHeaderView: UITableViewHeaderFooterView {
    
    //MARK::- Outlets
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var constraintLabelLeading: NSLayoutConstraint!
    
    
    //MARK::- PROPERTIES
    var delegate : HomeHeaderDelegate?
    
    var item: Any?{
        didSet{
            labelHeader?.text = /(item as? CourseObjective)?.title
        }
    }
    
    
}
