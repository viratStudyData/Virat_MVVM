//
//  TableViewDataSource.swift
//  Realm
//
//  Created by Night Reaper on 29/09/15.
//  Copyright (c) 2015 Gagan. All rights reserved.
//


import UIKit

typealias  ListCellConfigureBlock = (_ cell : Any , _ item : Any? , _ indexpath: IndexPath) -> ()
//typealias  ListCellConfigureBlock = (_ cell : Any, _ indexpath: IndexPath) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath) -> ()
typealias  ScrollViewDidScroll = (_ scrollView : UIScrollView) -> ()
typealias  ViewForHeaderInSection = (_ section : Int) -> UIView?
typealias  ViewForFooterInSection = (_ section : Int) -> UIView?
typealias  WillDisplayTableViewCellBlock = (_ cell : UITableViewCell , _ indexpath : IndexPath) -> ()
typealias  ChangeCellIdentifier = (_ indexPath : IndexPath) -> String?
typealias  ChangeCellHeight = (_ indexPath : IndexPath) -> CGFloat?

class TableViewDataSource: NSObject  {
    
    var items : Array<Any>?
    var cellIdentifier : String?
    var tableView  : UITableView?
    var tableViewRowHeight : CGFloat = 44.0
    var numberOfSections : Int?
    var numberOfSectionRows : [Int]?
    var configureCellBlock: ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var ScrollViewListener : ScrollViewDidScroll?
    var viewforHeaderInSection : ViewForHeaderInSection?
    var viewForFooterInSection : ViewForFooterInSection?
    var headerHeight : CGFloat? = 0.0
    var willDisplayCell: WillDisplayTableViewCellBlock?
    var willChangeIdentifier: ChangeCellIdentifier?
    var willChangeCellHeight: ChangeCellHeight?
    
    
    init (items : Array<Any>? , height : CGFloat , tableView : UITableView? , cellIdentifier : String , sectionRows : [Int] = []) {
        self.tableView = tableView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.tableViewRowHeight = height
       
       numberOfSectionRows = numberOfSectionRows == [] ? [/items?.count] : sectionRows
        
        
    }
    
    override init() {
        super.init()
        
    }
    
    
}

extension TableViewDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var identifier = willChangeIdentifier?(indexPath)
        if identifier == nil {
            identifier = cellIdentifier
        }
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: /identifier , for: indexPath) as UITableViewCell
        cell.isExclusiveTouch = true
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if let block = self.configureCellBlock , let item: Any = ( /numberOfSectionRows?.count == 1 ? self.items?[indexPath.row] : ""){
            block(cell , item , indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let block = self.willDisplayCell{
            block(cell, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = self.aRowSelectedListener{
            block(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return /numberOfSectionRows?[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return /numberOfSectionRows?.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cellHeight = willChangeCellHeight?(indexPath) {
            return cellHeight
        }
        return self.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let block = viewforHeaderInSection else { return nil }
        return block(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let block = viewForFooterInSection else { return nil }
        return block(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return headerHeight ?? 0.0
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return  200.0
    }
    
    
}
