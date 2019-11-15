//
//  InstProfileVC.swift
//  CourseApp
//
//  Created by Apple on 02/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class InstProfileVC: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var viewBG: UIView!{
        didSet{
            viewBG.addBoottomBorder()
        }
    }
    
    //MARK::- VIEW MODAL
    let viewModel = ProfileViewModel()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
}

extension InstProfileVC {
    
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        cellForRowAt = { ( cell ,_, indexPath) in
            (cell as? ProfileCell)?.data = Profile(indexPath: indexPath)
        }
        configureTableView(item: viewModel.titlesArray, tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.profileCell.identifier] , screenType: .generic , rowHeight: UITableView.automaticDimension,sectionRows: [viewModel.titlesArray.count])
        
    }
    
}
