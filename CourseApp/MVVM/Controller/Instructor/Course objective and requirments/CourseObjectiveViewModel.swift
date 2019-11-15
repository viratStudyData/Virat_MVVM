//
//  CourseObjectiveViewModel.swift
//  CourseApp
//
//  Created by Apple on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseObjectiveViewModel: NSObject {
    
    var titlesArray = [R.string.localizedStrings.learningObjectives(),R.string.localizedStrings.courseRequirements(),R.string.localizedStrings.targetStudents()]
    var arraySection1 = [R.string.localizedStrings.objectivePlaceholder1()]
    var arraySection2 = [R.string.localizedStrings.objectivePlaceholder2()]
    var arraySection3 = [R.string.localizedStrings.objectivePlaceholder2()]
    
    var arraySections = [[String]]()
    
    //MARK::- OVERRIDE INIT
    override init() {
        arraySections = [arraySection1,arraySection2,arraySection3]
    }
    
    //MARK::- FUNCTIONS
    func navigateToCourseStructure() {
        guard let vc = R.storyboard.createCourse.courseStructureVC() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
}


class CourseObjective {
    
    //MARK::- PROPERTIES
    var title: String?
    var section : Int?
    //MARK::- FUNCTIONS
    init(indexPathsection :  Int) {
        section = indexPathsection
        title = CourseObjectiveViewModel().titlesArray[indexPathsection]
    }
    
}
