//
//  CourseCreationVC.swift
//  CourseApp
//
//  Created by Apple on 30/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseCreationVC: CreateCourseBaseVC {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView:UITableView!
    //MARK::- VIEW MODAL
    
    let viewModel = CreateCourseViewModel()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    //MARK::- FUNCTIONS
}

extension CourseCreationVC {
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        cellForRowAt = { ( cell ,_, indexPath) in
            (cell as? CourseCreationCell)?.data = CreateCourse(indexPath: indexPath)
        }
        let cellHeight = (UIScreen.main.bounds.height * 23) / 100
        configureTableView(item: viewModel.titlesArray, tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.courseCreationCell.identifier] , screenType: .generic , rowHeight: cellHeight,sectionRows: [viewModel.titlesArray.count])
    }
}
