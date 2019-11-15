//
//  SelectCourseTypeVC.swift
//  CourseApp
//
//  Created by Apple on 01/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit



class SelectCourseTypeVC: CreateCourseBaseVC {
    
    //MARK::- OUTLETS
    
    @IBOutlet var buttonCoursesType: [UIButton]!
    
    //MARK::- VIEW MODAL
    let viewModel = CreateCourseViewModel()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        selectButton(button: buttonCoursesType[0])
    }
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnActionSelectCourse(_ sender: UIButton) {
        deselectButtons()
        selectButton(button: sender)
    }
    
    //MARK::- FUNCTIONS
    
    //MARK::- BUTTON ACTIONS
      @IBAction func btnActionContinue(_ sender: Any) {
          viewModel.navigateToSubmitCourse()
      }
    
    func deselectButtons()  {
        buttonCoursesType.forEach { (button) in
            button.isSelected = false
            button.backgroundColor = .white
        }
    }
   
    func selectButton(button : UIButton)  {
        button.isSelected = true
        button.backgroundColor = UIColor(named: "colorToggle")
        
    }
    
    
}
