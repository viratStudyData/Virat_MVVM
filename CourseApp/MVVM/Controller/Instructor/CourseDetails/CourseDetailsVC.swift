//
//  CourseDetailVC.swift
//  CourseApp
//
//  Created by Apple on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseDetailsVC: CreateCourseBaseVC {
    
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView:UITableView!
    
    //MARK::- PROPERTIES
    
    let viewModel = CourseDetailsViewModel()
    
    //MARK::- VIEW CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    //MARK::- BUTTON ACTIONS
      @IBAction func btnActionContinue(_ sender: Any) {
          viewModel.navigateToCourseObjective()
      }
}


extension CourseDetailsVC {
    
    //MARK: - CONFIGURE TABLEVIEW
    func configureTableView() {
        
        tableView.registerCell(identifier: R.reuseIdentifier.courseDetailTextViewCell.identifier)
        
        didSelectRow = {indexPath in
            //            self?.viewModel.navigateToCategory()
        }
        willChangeIdentifier = { indexPath in
            if indexPath.row == 6  {
                return R.reuseIdentifier.courseDetailTextViewCell.identifier
            }
            return R.reuseIdentifier.courseDetailsCell.identifier
            
        }
        
        willChangeCellHeight = { indexPath in
            if indexPath.row == 6  {
                return CGFloat().percent(15)
            }
            return CGFloat().percent(11)
            
        }
        
        cellForRowAt = { ( cell ,_, indexPath) in
            (cell as? CourseDetailTextViewCell)?.data = CourseDetails(indexPath: indexPath)
            (cell as? CourseDetailsCell)?.data = CourseDetails(indexPath: indexPath)
        }
        let cellHeight = CGFloat().percent(11)
        self.configureTableView(item: self.viewModel.placeholders, tableView: tableView, cellIdentifier: [R.reuseIdentifier.courseDetailsCell.identifier], screenType: .generic, rowHeight:cellHeight ,sectionRows: [self.viewModel.placeholders.count])
        
    }
}
