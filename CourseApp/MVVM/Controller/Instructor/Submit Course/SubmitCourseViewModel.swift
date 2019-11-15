//
//  SubmitCourseViewModel.swift
//  CourseApp
//
//  Created by Apple on 05/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class SubmitCourseViewModel: NSObject {
    
    //MARK::- PROPERTIES

    var arraySection1 = [R.string.localizedStrings.planYourCourses(),R.string.localizedStrings.courseDetail(),R.string.localizedStrings.courseObjectiveAndRequirments(),R.string.localizedStrings.courseStructure(),R.string.localizedStrings.setUpTesting()]
    
    var arraySection2 = [R.string.localizedStrings.createYourContent(),R.string.localizedStrings.createCurriculum(),R.string.localizedStrings.addSubtitles(),R.string.localizedStrings.bookYourCalender()]
    
    var arraySection3 = [R.string.localizedStrings.publishYourCourses(),R.string.localizedStrings.pricing(),R.string.localizedStrings.promotions(),R.string.localizedStrings.courseMessages()]
    
    var arraySections = [[String]]()
    var backupArraySections : [[String]]?
    
    
    
    //MARK::- OVERRIDE INIT
    override init() {
        arraySections = [arraySection1,arraySection2,arraySection3]
        backupArraySections = [arraySection1,arraySection2,arraySection3]
    }
    
    //MARK::- FUNCTIONS
    func navigateToCourseDetails() {
        guard let vc = R.storyboard.createCourse.courseDetailsVC() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
   
}


class SubmitCourse {
    
    //MARK::- PROPERTIES
    
    var title: String?
    var index: Int?
    
    //MARK::- FUNCTIONS
    
    
    init(indexPath :  IndexPath ) {
        index = indexPath.row
        title = SubmitCourseViewModel().arraySections[indexPath.section][indexPath.row]
    }
    
}
