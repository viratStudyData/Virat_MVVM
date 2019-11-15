//
//  VideoQuestionsVC.swift
//  CourseApp
//
//  Created by Apple on 25/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class VideoQuestionsVC: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView:UITableView!
    
    //MARK::- VIEW MODAL
    let viewModel = CatQuestViewModel()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.isCatSelected = false
        configureTableView()
    }
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnActionContinue(_ sender: Any) {
        viewModel.navigateToDashboard()
    }
}
extension VideoQuestionsVC {
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        tableView.registerCell(identifier: R.reuseIdentifier.questTableCell.identifier)
        cellForRowAt = { ( cell,_, indexPath) in
            (cell as? QuestTableCell)?.item = Questions(indexPath: indexPath ,isCat: false)
            (cell as? QuestTableCell)?.viewModel = self.viewModel

        }
        let cellHeight = (UIScreen.main.bounds.height * 5) / 100
        constraintTableHeight.constant = cellHeight * CGFloat(viewModel.videoOptionsArray.count + 2 )
        configureTableView(item: viewModel.videoQuestionsArray, tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.questTableCell.identifier] , screenType: .generic , rowHeight: UITableView.automaticDimension,sectionRows: [viewModel.videoQuestionsArray.count])
    }
}
