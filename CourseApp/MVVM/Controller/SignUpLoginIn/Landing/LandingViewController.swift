//
//  LandingViewController.swift
//  Course
//
//  Created by Mac_Mini17 on 16/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class LandingViewController: BaseViewController {
    
    //MARK::- OUTLETS
    
    
    
    //MARK::- PROPERTIES
    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }
    
    //MARK::- FUNCTIONS
    
    func onLoad(){
        if /UserPreference.shared.user?.data?.accessToken != ""{
            moveToUserDashboard()
        }
    }
    
    //MARK::- ACTIONS
    @IBAction func btnActionChangeLanguage(_ sender: UIButton) {
        changeLanguage()
    }
    
    @IBAction func btnActionSignIn(_ sender: UIButton) {
        //        moveToUserDashboard()
        //                guard let vc = R.storyboard.userDashBoard.becomeInstructorViewController() else { return }
        
//                guard let vc = R.storyboard.main.signInViewController() else { return }
//        guard let vc = R.storyboard.instructorDashboard.instHomeVC() else { return }
        
//        guard let vc = R.storyboard.createCourse.courseObjectiveVC() else { return }
        guard let vc = R.storyboard.createCourse.submitCourseVC() else {return}

        pushVc(vc: vc)
    }
    
    @IBAction func btnActionBrowseCourses(_ sender: UIButton) {
        moveToUserDashboard()
    }
    
}
