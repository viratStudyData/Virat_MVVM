//
//  InstHomeViewModel.swift
//  CourseApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit




class InstHomeViewModel: NSObject {
    
    //MARK::- PROPERTIES
    
    lazy var instHomeArray = [InstHome]()
    var titles = [R.string.localizedStrings.createACourse(),R.string.localizedStrings.allCourses(),R.string.localizedStrings.approved(),R.string.localizedStrings.pendingForApproval(),R.string.localizedStrings.savedInDrafts()]
    var titlesDesc = [R.string.localizedStrings.createCourseDesc(),R.string.localizedStrings.allcoursesDesc(),R.string.localizedStrings.allcoursesDesc(),R.string.localizedStrings.pendingDesc(),R.string.localizedStrings.draftsDesc()]
    
    var leadingIcons = [R.image.ic_create_course(),R.image.ic_All_course(),R.image.ic_approved_courses(),R.image.ic_pending_courses(),R.image.ic_draft_courses()]
    
    var iconsColors = [R.color.colorCreateCourse(),R.color.colorLink(),R.color.colorApproved(),R.color.colorCreateCourse(),R.color.colorDrafts()]
    
    //MARK::- FUNCTIONS
    
    func navigateToCategory() {
        guard let vc = R.storyboard.instructorDashboard.categoryQuestionsVC() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
}

class InstHome {
    
    //MARK::- PROPERTIES
    
    var title: String?
    var desc: String?
    var icon: UIImage?
    var color: UIColor?
    var index: Int?
    var count: Int?
    
    //MARK::- FUNCTIONS
    
    init(indexPath :  IndexPath ) {
        index = indexPath.row
        count = InstHomeViewModel().titles.count
        title = InstHomeViewModel().titles[indexPath.row]
        desc = InstHomeViewModel().titlesDesc[indexPath.row]
        icon = InstHomeViewModel().leadingIcons[indexPath.row]
        color = InstHomeViewModel().iconsColors[indexPath.row]
    }
    
}

