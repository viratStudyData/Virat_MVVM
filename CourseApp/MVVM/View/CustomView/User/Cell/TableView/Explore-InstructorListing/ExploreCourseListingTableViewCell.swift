//
//  ExploreCourseListingTableViewCell.swift
//  CourseApp
//
//  Created by Harminder on 03/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreCourseListingTableViewCell: BaseTableViewCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.registerXIB(R.reuseIdentifier.exploreCourseCollectionViewCell.identifier)
            
        }
    }
    @IBOutlet weak var labelHeading: UILabel!
    
    //MARK::- PROPERTIES
    var data = [Any](){
        didSet{
            configureCollectionView()
        }
    }
    
    
    //MARK::- VIEW CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK::- FUNCTIONS
    
    func configureCollectionView(){
        //configure instructor listing collection
        let height = ScreenSize.SCREEN_HEIGHT/2.2 - 74
        cellForRowAt = { (cell,item,indexpath) in
            (cell as? ExploreCourseCollectionViewCell)?.item = item
        }
        
        didSelectRow = { (indexpath) in
            print(indexpath)
        }
        
        
        configureCollectionView(item: data , collectionView: collectionView, cellIdentifier: [R.reuseIdentifier.exploreCourseCollectionViewCell.identifier], screenType: .generic, cellSize: CGSize(width: ScreenSize.SCREEN_WIDTH / 1.5 , height: height), lineSpacing: 0, interItemSpace: 0 , edgeInsetsMake: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), sectionHeaderHeight: CGSize(width: 0, height: 0))
        collectionView.reloadData()
    }
    
}
