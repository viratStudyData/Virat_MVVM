//
//  BaseTableViewCell.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 29/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var tableViewDataSource: TableViewDataSource?
    var collectionViewDataSource : CollectionViewDataSource?
    var cellForRowAt: ListCellConfigureBlock?
    var didSelectRow : DidSelectedRow?
    var viewForHeader: ViewForHeaderInSection?
    var willChangeIdentifier: ChangeCellIdentifier?
    var headerHeight : CGFloat = 0.0
    
    enum ScreenTypes{
        case generic
        
    }
    
    //MARK::- CONFIGURE COLLECTIONVIEW
    func configureTableView(item:[Any] , tableView: UITableView , cellIdentifier: [String] , screenType: ScreenTypes , rowHeight : CGFloat = 64 ){
        
        switch screenType {
            
        case .generic:
            tableViewDataSource = TableViewDataSource(items: item, height: rowHeight, tableView: tableView, cellIdentifier: /cellIdentifier.first)
            
        }
        tableViewDataSource?.configureCellBlock = cellForRowAt
        tableViewDataSource?.aRowSelectedListener = didSelectRow
        tableViewDataSource?.viewforHeaderInSection = viewForHeader
        tableViewDataSource?.headerHeight = headerHeight
        tableViewDataSource?.willChangeIdentifier = willChangeIdentifier
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        tableView.reloadData()
        
        
    }
    
    func configureCollectionView(item:[Any] , collectionView: UICollectionView , cellIdentifier: [String] , screenType: ScreenTypes , cellSize : CGSize , lineSpacing: CGFloat , interItemSpace: CGFloat , edgeInsetsMake: UIEdgeInsets? , sectionHeaderHeight: CGSize? ){
        
        switch screenType {
            
        case .generic:
            collectionViewDataSource = CollectionViewDataSource(items: item , collectionView: collectionView, cellIdentifier: /cellIdentifier.first , headerIdentifier: "", cellHeight: cellSize.height, cellWidth: cellSize.width, minimumLineSpacing: lineSpacing , minimumInteritemSpacing: interItemSpace , edgeInsetsMake: edgeInsetsMake ??  UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 ), sectionHeaderHeight: sectionHeaderHeight ?? CGSize.zero)
            
        }
        collectionViewDataSource?.configureCellBlock = cellForRowAt
        collectionViewDataSource?.aRowSelectedListener = didSelectRow
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDataSource
        collectionView.reloadData()
        
        
    }
    
}
