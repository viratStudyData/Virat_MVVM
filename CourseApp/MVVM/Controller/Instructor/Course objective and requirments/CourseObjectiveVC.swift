//
//  CourseObjectiveVC.swift
//  CourseApp
//
//  Created by Apple on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CourseObjectiveVC: CreateCourseBaseVC {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var viewHeader:UIView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    
    
    //MARK::- PROPERTIES
    
    let viewModel = CourseObjectiveViewModel()
    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnActionContinue(_ sender: Any) {
        viewModel.navigateToCourseStructure()
    }
}

extension CourseObjectiveVC {
    
    //MARK: - CONFIGURE TABLEVIEW
    func configureTableView() {
        // UINib(resource: R.nib.homeHeaderView)
        tableView.register(UINib(resource: R.nib.homeHeaderView)  , forHeaderFooterViewReuseIdentifier: R.nib.homeHeaderView.name )
        tableView.register(UINib(resource: R.nib.courseObjectiveFooterView)  , forHeaderFooterViewReuseIdentifier: R.nib.courseObjectiveFooterView.name )
        
        didSelectRow = {indexPath in
        }
        
        viewForHeader = { [weak self] section in
            let header = self?.tableView?.dequeueReusableHeaderFooterView(withIdentifier: R.nib.homeHeaderView.name)
            (header as? HomeHeaderView)?.item = CourseObjective(indexPathsection:section)
            return header
        }
        viewForFooter = { [weak self] section in
            let footer = self?.tableView?.dequeueReusableHeaderFooterView(withIdentifier: R.nib.courseObjectiveFooterView.name)
            (footer as? CourseObjectiveFooterView)?.item = CourseObjective(indexPathsection:section)
            (footer as? CourseObjectiveFooterView)?.addAnswer = { selectedSection in
                print(selectedSection)
                self?.viewModel.arraySections[selectedSection].append((/self?.viewModel.arraySections[selectedSection].first))
                self?.tableViewDataSource?.numberOfSectionRows = self?.retrieveSections()
                self?.tableViewDataSource?.items = self?.viewModel.arraySections
                self?.tableView.reloadData()
            }
            //            (header as? HomeHeaderView)?.item = CourseObjective(indexPathsection:section)
            return footer
        }
        
        self.headerHeight = CGFloat().percent(6)
        
        cellForRowAt = { ( cell ,_, indexPath) in
            //              (cell as? CourseObjectiveCell)?.item = CourseDetails(indexPath: indexPath)
        }
        let cellHeight = CGFloat().percent(6)
        self.configureTableView(item: self.viewModel.arraySections, tableView: tableView, cellIdentifier: [R.reuseIdentifier.courseObjectiveCell.identifier], screenType: .generic, rowHeight:cellHeight, sectionRows: retrieveSections() )
        
    }
    
    func retrieveSections() -> [Int]{
        return [viewModel.arraySections[0].count,viewModel.arraySections[1].count,viewModel.arraySections[2].count]
    }
    
}
