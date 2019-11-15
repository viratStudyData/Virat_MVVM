//
//  CourseCreationCell.swift
//  CourseApp
//
//  Created by Apple on 30/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseCreationCell: UITableViewCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var cellBG: UIView!
    
    //MARK::- VIEW MODAL
    let viewModel = CreateCourseViewModel()
    
    //MARK::- PROPERTIES
    
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
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnActionContinue(_ sender: UIButton) {
        sender.tag == 0 ? viewModel.navigateToSetCourseTitle() : ()
    }
    
    //MARK::- FUNCTIONS
    func configureControls() {
        guard let createCourse = data as? CreateCourse else {return}
        labelTitle?.text = createCourse.title
        labelDesc?.text = createCourse.desc
        buttonContinue.tag = /createCourse.index
        buttonContinue.setTitle(createCourse.buttonTitle, for: .normal)
        cellBG.backgroundColor = createCourse.index == 0 ? UIColor.white : UIColor.init(named: "ColorCell")
        buttonContinue.setTitleColor(createCourse.index == 0 ? UIColor.init(named: "colorThemeHeadings") : UIColor.init(named: "colorHeadings"), for: .normal)
        buttonContinue.backgroundColor = createCourse.index == 0 ? UIColor.init(named: "colorTheme") : UIColor.clear
        buttonContinue.borderColor = (createCourse.index == 0 ? UIColor.init(named: "colorThemeBorder") : UIColor.init(named: "colorHeadings"))!
    }
}

