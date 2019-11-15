//
//  QuestTableCell.swift
//  CourseApp
//
//  Created by Apple on 23/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class QuestTableCell: BaseTableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView:UITableView!
    
    //MARK::- PROPERTIES
    var viewModel = CatQuestViewModel()
    var heightBlock : ((_ increase : Bool) -> ())?
    
    var item: Any?{
        didSet{
            labelQuestion?.text = /(item as? Questions)?.title
            configureTableView()
        }
    }
    var dataSource:TableViewDataSource? {
        didSet {
            tableView?.dataSource = dataSource
            tableView?.delegate = dataSource
            
        }
    }
    
    //MARK::- OVERRIDE FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - CONFIGURE TABLEVIEW
    
    func configureTableView() {
        tableView.registerCell(identifier: R.reuseIdentifier.ansTableCell.identifier)
        tableView.registerCell(identifier: R.reuseIdentifier.textViewCell.identifier)
        
        /(self.item as? Questions)?.categorySelected ? viewModel.optionsArray.contains("demo") ? () : viewModel.optionsArray.append("demo") : ()
        
        print(/(self.item as? Questions)?.categorySelected)
        willChangeIdentifier = { indexPath in
            if indexPath.row == 4  {
                return R.reuseIdentifier.textViewCell.identifier
            }
            return R.reuseIdentifier.ansTableCell.identifier
        }
        
        cellForRowAt = {[weak self]( cell,_,indexPath) in
            
            (cell as? AnsTableCell)?.buttonAns.isSelected =  (/self?.viewModel.selectedOptIndex.contains(indexPath.row)) ? true : false
            (cell as? TextViewCell)?.item = "demo"
            //If the category view is visible
            (cell as? TextViewCell)?.textViewOther.isHidden = /(self?.item as? Questions)?.categorySelected ? indexPath.row == 4 ? /self?.viewModel.isQustionSelected : true : true
            (cell as? AnsTableCell)?.item = QuestOpt(indexPath: indexPath , isCat: /(self?.item as? Questions)?.categorySelected)
            (cell as? AnsTableCell)?.buttonAns.tag = indexPath.row
            (cell as? AnsTableCell)?.optionSelection = { [weak self] selectedOptn in
                (/self?.viewModel.selectedOptIndex.contains(selectedOptn.tag)) ? self?.viewModel.selectedOptIndex.removeElement(element:selectedOptn.tag) : self?.viewModel.selectedOptIndex.append(selectedOptn.tag)
                self?.viewModel.selectedIndex = selectedOptn.tag
                self?.viewModel.isQustionSelected =  (/self?.viewModel.selectedOptIndex.contains(3)) ? false : true
                (/self?.viewModel.selectedOptIndex.contains(3)) ? self?.heightBlock?(true) : self?.heightBlock?(false)
                self?.tableView.reloadData()
            }
        }
        let cellHeight = (UIScreen.main.bounds.height *  6) / 100
        constraintTableHeight.constant = cellHeight * CGFloat(viewModel.optionsArray.count)
        configureTableView(item: viewModel.optionsArray , tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.ansTableCell.identifier] , screenType: .generic , rowHeight: UITableView.automaticDimension)
    }
    
}

class AnsTableCell: UITableViewCell {
    
    //MARK::- PROPERTIES
    
    //MARK::- OUTLETS
    @IBOutlet weak var buttonAns: UIButton!
    
    //MARK::- PROPERTIES
    var optionSelection : ((_ selectedOption : UIButton) -> ())?
    
    var item: Any?{
        didSet{
            buttonAns.setTitle(/(item as? QuestOpt)?.title, for: .normal)
        }
    }
    
    //MARK::- OVERRIDE FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //MARK::- BUTTON ACTIONS
    @IBAction func selectOption(_ sender: UIButton) {
        //sender.isSelected = sender.isSelected ? false  : true
        optionSelection?(sender)
        
    }
    
}


class TextViewCell: UITableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var textViewOther: UITextView!
    var item: Any?
    
    //MARK::- PROPERTIES
    var optionSelection : ((_ button : UIButton) -> ())?
    
    
    //MARK::- OVERRIDE FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //MARK::- BUTTON ACTIONS
    
}

