//
//  CourseDetailsViewModel.swift
//  CourseApp
//
//  Created by Apple on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseDetailsViewModel: NSObject {
    var placeholders = [R.string.localizedStrings.coursesTitle(),R.string.localizedStrings.courseCatergory(),R.string.localizedStrings.courseSubCatergory(),R.string.localizedStrings.courseType(),R.string.localizedStrings.courseLanguage(),R.string.localizedStrings.suitableaudience(),R.string.localizedStrings.courseDetails()]
    
    //MARK::- FUNCTIONS
    
    func navigateToCourseObjective() {
        guard let vc = R.storyboard.createCourse.courseObjectiveVC() else { return }
        //        guard let vc = R.storyboard.createCourse.courseStructureVC() else { return }
        
        UIApplication.topViewController()?.pushVC(vc)
    }
    
}
class CourseDetails {
    
    //MARK::- PROPERTIES
    
    var title: String?
    var index: Int?
    
    //MARK::- FUNCTIONS
    
    init(indexPath :  IndexPath ) {
        index = indexPath.row
        title = CourseDetailsViewModel().placeholders[indexPath.row]
    }
    
}
