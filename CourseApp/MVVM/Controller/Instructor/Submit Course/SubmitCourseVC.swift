//
//  SubmitCourseVC.swift
//  CourseApp
//
//  Created by Apple on 04/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class SubmitCourseVC: CreateCourseBaseVC {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView:UITableView!
    
    //MARK::- PROPERTIES
    
    
    //MARK::- VIEW MODAL
    let viewModel = SubmitCourseViewModel()
    
    
    //MARK::- VIEW CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
}

extension SubmitCourseVC {
    
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        
        didSelectRow = { [weak self] indexPath in
            
            
            if indexPath.row == 0 {
                if /self?.viewModel.arraySections[indexPath.section].count <  /(self?.viewModel.backupArraySections?[indexPath.section].count) {
                    self?.viewModel.arraySections[indexPath.section] = self?.viewModel.backupArraySections?[/indexPath.section] ?? []
                }else {
                    self?.viewModel.arraySections[indexPath.section] = [/(self?.viewModel.arraySections[indexPath.section][indexPath.row])]
                }
                self?.configureTableView()
            } else {
                self?.viewModel.navigateToCourseDetails()
            }
        }
        
        cellForRowAt = {  [weak self] ( cell ,_, indexPath) in
            (cell as? SubmitCourseCell)?.data = SubmitCourse(indexPath: indexPath)
            
            if  /self?.viewModel.arraySections[indexPath.section].count == 1 {
                (cell as? SubmitCourseCell)?.imageIcon.transform = CGAffineTransform(rotationAngle: .pi)
            }else
            {
                (cell as? SubmitCourseCell)?.imageIcon.transform = CGAffineTransform(rotationAngle: 0)
            }
            
        }
        let cellHeight = CGFloat().percent(7)
        configureTableView(item: viewModel.arraySection1, tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.submitCourseCell.identifier] , screenType: .generic , rowHeight:cellHeight,sectionRows: [self.viewModel.arraySections[0].count,viewModel.arraySections[1].count,viewModel.arraySections[2].count])
        
    }
    
}


