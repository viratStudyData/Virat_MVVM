//
//  HomeHeaderView.swift
//  NequoreUser
//
//  Created by cbl24_Mac_mini on 10/07/18.
//

import UIKit

protocol CourseObjectiveDelegate : class {
    func showDetails(tag:Int?)
}

typealias AddAnswerInSection = (_ section : Int) -> ()

class CourseObjectiveFooterView: UITableViewHeaderFooterView {
    
    //MARK::- Outlets
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var buttonAddAns: UIButton!
    @IBOutlet weak var constraintLabelLeading: NSLayoutConstraint!
    
    
    //MARK::- PROPERTIES
    var delegate : CourseObjectiveDelegate?
    var addAnswer : AddAnswerInSection?
    
    var item: Any?{
        didSet{
            buttonAddAns.tag = /(item as? CourseObjective)?.section

        }
    }
    
    //MARK::- BUTTON ACTIONS
    
    @IBAction func clickAddAnswer(_ sender: UIButton) {
        addAnswer?(sender.tag)
        
    }
    
    
}
