//
//  ExploreTableViewDataSource.swift
//  CourseApp
//
//  Created by Harminder on 04/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreTableViewDataSource: TableViewDataSource {
    
    var home: HomeData?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch /indexPath.row{
        case 0:
            cellIdentifier = R.reuseIdentifier.exploreCategoriesTableViewCell.identifier
        case 1,3,4,5:
            cellIdentifier = R.reuseIdentifier.exploreCourseListingTableViewCell.identifier
        case 2:
            cellIdentifier = R.reuseIdentifier.exploreInstructorListingTableViewCell.identifier
        default:
            cellIdentifier = R.reuseIdentifier.exploreCategoriesTableViewCell.identifier
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: /cellIdentifier , for: indexPath) as UITableViewCell
        cell.isExclusiveTouch = true
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if let block = self.configureCellBlock , let item: Any = self.items?[indexPath.row]{
            block(cell , item , indexPath)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch /indexPath.row{
        case 0:
            return /home?.data?.categories?.count == 0 ? 0 : UIScreen.main.bounds.height/4
            
        case 1:
            return /home?.data?.bestSelling?.count == 0 ? 0 : UIScreen.main.bounds.height/2.2
        case 3:return /home?.data?.featureCourses?.count == 0 ? 0 : UIScreen.main.bounds.height/2.2
        case 4:return /home?.data?.trendingCourses?.count == 0 ? 0 : UIScreen.main.bounds.height/2.2
        case 5:return /home?.data?.upcomingCourses?.count == 0 ? 0 : UIScreen.main.bounds.height/2.2
        case 2:
            return /home?.data?.instructors?.count == 0 ? 0 : UIScreen.main.bounds.height/5
        default:
            return 0
        }
    }
    
    
    
}
