//
//  CategoryQuestionsVC.swift
//  CourseApp
//
//  Created by Apple on 23/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CategoryQuestionsVC: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var textFieldCategory:UITextField!
    
    //MARK::- PROPERTIES
    let viewModel = CatQuestViewModel()
    var increaseHeight = false
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureTableView()
        textFieldCategory.addTarget(self, action: #selector(showPicker), for: .editingDidBegin)
        self.viewModel.isCatSelected = true
    }
    
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnActionContinue(_ sender: Any) {
        viewModel.navigateToVideoQuestions()
    }
    
    //MARK::- FUNCTIONS
    
    @objc func showPicker() {
        viewModel.configurePicker()
    }
    
}

extension CategoryQuestionsVC {
    
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        tableView.registerCell(identifier: R.reuseIdentifier.questTableCell.identifier)
        cellForRowAt = {( cell ,_,indexPath) in
            (cell as? QuestTableCell)?.item = Questions(indexPath: indexPath ,isCat: true)
            (cell as? QuestTableCell)?.viewModel = self.viewModel
            (cell as? QuestTableCell)?.heightBlock = { [weak self] isHeight in
                self?.increaseHeight = isHeight
                self?.configureTableView()
            }
        }
        let cellHeight = CGFloat().percent(5)
        constraintTableHeight.constant = cellHeight * CGFloat(viewModel.optionsArray.count + (increaseHeight ? 4 : 2))
        configureTableView(item: viewModel.questionsArray, tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.questTableCell.identifier] , screenType: .generic , rowHeight: UITableView.automaticDimension,sectionRows: [viewModel.questionsArray.count])
        
    }
    
}

