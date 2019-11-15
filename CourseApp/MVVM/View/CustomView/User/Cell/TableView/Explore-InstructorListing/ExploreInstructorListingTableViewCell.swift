//
//  ExploreInstructorListingTableViewCell.swift
//  CourseApp
//
//  Created by Harminder on 03/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreInstructorListingTableViewCell: BaseTableViewCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.registerXIB(R.reuseIdentifier.instructorListingCollectionViewCell.identifier)
            
        }
    }
    //MARK::- PROPERTIES
    var data = [Any](){
        didSet{
            configureCollectionView()
        }
    }
    
    
    //MARK::- OVVERIDE FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK::- FUNCTIONS
    
    //MARK::- CONFIGURE COLLECTION VIEW
    
    
    func configureCollectionView(){
        //configure instructor listing collection
        let height = ScreenSize.SCREEN_HEIGHT/5  - 74
        
        cellForRowAt = { (cell,item,indexpath) in
            (cell as? InstructorListingCollectionViewCell)?.item = item
        }
        
        didSelectRow = { (indexpath) in
            
        }
        
        configureCollectionView(item: data , collectionView: collectionView, cellIdentifier: [R.reuseIdentifier.instructorListingCollectionViewCell.identifier], screenType: .generic, cellSize: CGSize(width:UIScreen.main.bounds.width/2  , height: height), lineSpacing: 0, interItemSpace: 0 , edgeInsetsMake: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), sectionHeaderHeight: CGSize(width: 0, height: 0))
        
        collectionView.reloadData()
        
    }
}
