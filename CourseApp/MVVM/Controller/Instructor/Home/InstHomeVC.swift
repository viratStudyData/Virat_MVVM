//
//  InstHomeVC.swift
//  CourseApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class InstHomeVC: CreateCourseBaseVC {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    
    //MARK::- PROPERTIES
    let viewModel = InstHomeViewModel()
    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension InstHomeVC {
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        
        didSelectRow = { [weak self] indexPath in
            self?.viewModel.navigateToCategory()
        }
        
        cellForRowAt = { ( cell ,_, indexPath) in
            
            (cell as? InstHomeTableCell)?.data = InstHome(indexPath: indexPath)
            (cell as? InstHomeTableCell)?.isConfigureCell = true
            
        }
        
        let cellHeight = (UIScreen.main.bounds.height * 12) / 100
        constraintTableHeight.constant = cellHeight * 5
        tableViewDataSource?.tableViewRowHeight = cellHeight
        self.configureTableView(item: self.viewModel.titles, tableView: tableView, cellIdentifier: [R.reuseIdentifier.instHomeTableCell.identifier], screenType: .generic, rowHeight: cellHeight,sectionRows: [self.viewModel.titles.count])
        
    }
}
