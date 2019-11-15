//
//  CourseTitleVC.swift
//  CourseApp
//
//  Created by Apple on 01/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseTitleVC: CreateCourseBaseVC {

    //MARK::- VIEW MODAL
    let viewModel = CreateCourseViewModel()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   //MARK::- BUTTON ACTIONS
   @IBAction func btnActionContinue(_ sender: Any) {
       viewModel.navigateToSetCourseCategory()
   }

}
