//
//  UserProfileViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- PROPERTIES
    
    var profileVM = UserProfileViewModal()
    
    //MARK::- VIEW CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    //MARK::- FUNCTIONS
    
}

//MARK::- CONFIGURE TABLEVIEW
extension UserProfileViewController {
    
    func configureTableView() {
        
        cellForRowAt = { ( cell , item , indexPath) in
            (cell as? UserProfileTableViewCell)?.profile = item
        }
        
        didSelectRow = { [weak self] indexPath in
            switch indexPath.row{
            case 1:
                guard let vc = R.storyboard.userDashBoard.becomeInstructorViewController() else { return }
                self?.pushVC(vc)
            case 6://logout
                self?.showAlert(message: "Are you sure to logout?", title: "LOGOUT") {
                    self?.profileVM.signout()
                }
                
            default:break
            }
        }
        
        configureTableView(item: profileVM.elements, tableView: self.tableView, cellIdentifier: [R.reuseIdentifier.userProfileTableViewCell.identifier] , screenType: .generic , rowHeight: UITableView.automaticDimension)
        
    }
    
}
