//
//  UserExploreViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class UserExploreViewController: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBanner: BannerView!
    
    //MARK::- PROPERTIES
    
    var exploreVM = ExploreViewModal()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }
    
    //MARK::- FUNCTIONS
    func onLoad(){
        exploreVM.exploreHome { [weak self] in
            self?.configureTableView()
            self?.viewBanner.item = self?.exploreVM.exploreData?.data?.banners ?? []
        }
        
    }
    
    
}

//MARK::- CONFIGURE TABLEVIEW
extension UserExploreViewController {
    
    func configureTableView(){
        
        cellForRowAt = { [weak self] (cell,item,indexpath) in
            switch indexpath.row{
            case 0://category
                (cell as? ExploreCategoriesTableViewCell)?.labelHeading?.text = /self?.exploreVM.explores[indexpath.row]
                (cell as? ExploreCategoriesTableViewCell)?.data = self?.exploreVM.exploreData?.data?.categories ?? []
            case 1://best selling
                (cell as? ExploreCourseListingTableViewCell)?.labelHeading?.text = /self?.exploreVM.explores[indexpath.row]
                (cell as? ExploreCourseListingTableViewCell)?.data = self?.exploreVM.exploreData?.data?.bestSelling ?? []
            case 2://instructors
                (cell as? ExploreInstructorListingTableViewCell)?.labelHeading?.text = /self?.exploreVM.explores[indexpath.row]
                (cell as? ExploreInstructorListingTableViewCell)?.data = self?.exploreVM.exploreData?.data?.instructors ?? []
            case 3://featured courses
                (cell as? ExploreCourseListingTableViewCell)?.labelHeading?.text = /self?.exploreVM.explores[indexpath.row]
                (cell as? ExploreCourseListingTableViewCell)?.data = self?.exploreVM.exploreData?.data?.featureCourses ?? []
            case 4://trensing courses
                (cell as? ExploreCourseListingTableViewCell)?.labelHeading?.text = /self?.exploreVM.explores[indexpath.row]
                (cell as? ExploreCourseListingTableViewCell)?.data = self?.exploreVM.exploreData?.data?.trendingCourses ?? []
            default://upcoming courses
                (cell as? ExploreCourseListingTableViewCell)?.labelHeading?.text = /self?.exploreVM.explores[indexpath.row]
                (cell as? ExploreCourseListingTableViewCell)?.data = self?.exploreVM.exploreData?.data?.upcomingCourses ?? []
            }
        }
        
        didSelectRow = { [weak self] indexpath in
            
        }
        
        configureTableView(item: exploreVM.explores , tableView: tableView, cellIdentifier: [], screenType: .explore)
        (tableViewDataSource as? ExploreTableViewDataSource)?.home = exploreVM.exploreData
        tableView.reloadData()
    }
    
}


