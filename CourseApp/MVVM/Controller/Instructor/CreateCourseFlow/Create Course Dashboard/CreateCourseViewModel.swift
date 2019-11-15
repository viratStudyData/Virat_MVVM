//
//  DashboardViewModel.swift
//  CourseApp
//
//  Created by Apple on 30/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

enum CourseType : Int{
    case liveCourses = 0
    case recordedCourses
}

class CreateCourseViewModel: NSObject {
    
    //MARK::- PROPERTIES
    
    let titlesArray = [R.string.localizedStrings.courseTitle1(),R.string.localizedStrings.courseTitle2(),R.string.localizedStrings.courseTitle3(),R.string.localizedStrings.courseTitle4()]
    let descArray = [R.string.localizedStrings.courseDesc(),R.string.localizedStrings.courseDesc(),R.string.localizedStrings.courseDesc(),R.string.localizedStrings.courseDesc()]
    let buttonTitlesArray = [R.string.localizedStrings.courseButtonTitle(),R.string.localizedStrings.getstarteD(),R.string.localizedStrings.getstarteD(),R.string.localizedStrings.getstarteD()]
    
    var courseType : CourseType = .liveCourses
    
    //MARK::- FUNCTIONS
    func navigateToSetCourseTitle() {
        guard let vc = R.storyboard.createCourse.courseTitleVC() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func navigateToSetCourseCategory() {
        guard let vc = R.storyboard.createCourse.selectCourseCategoryVC() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func navigateToSelectCourseType() {
        guard let vc = R.storyboard.createCourse.selectCourseTypeVC() else {return}
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func navigateToSubmitCourse() {
        guard let vc = R.storyboard.createCourse.submitCourseVC() else {return}
        UIApplication.topViewController()?.pushVC(vc)
    }
}

class CreateCourse {
    
    //MARK::- PROPERTIES
    
    var title: String?
    var desc: String?
    var buttonTitle: String?
    var index: Int?
    
    //MARK::- FUNCTIONS
    
    init(indexPath :  IndexPath ) {
        index = indexPath.row
        title = CreateCourseViewModel().titlesArray[indexPath.row]
        desc = CreateCourseViewModel().descArray[indexPath.row]
        buttonTitle = CreateCourseViewModel().buttonTitlesArray[indexPath.row]
    }
    
}
