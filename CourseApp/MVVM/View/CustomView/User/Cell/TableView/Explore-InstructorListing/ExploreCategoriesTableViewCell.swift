//
//  ExploreCategoriesTableViewCell.swift
//  CourseApp
//
//  Created by Harminder on 04/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreCategoriesTableViewCell: BaseTableViewCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.registerXIB(R.reuseIdentifier.exploreCategoryCollectionViewCell.identifier)
            
        }
    }
    @IBOutlet weak var labelHeading: UILabel!
    
    //MARK::- PROPERTIES
    var data = [Any](){
        didSet{
            configureCollectionView()
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
    
    //MARK::- CONFIGURE COLLECTION VIEW
    
    func configureCollectionView(){
        //configure instructor listing collection
        
        cellForRowAt = { (cell,item,indexpath) in
            (cell as? ExploreCategoryCollectionViewCell)?.item = item
            
        }
        
        didSelectRow = { (indexpath) in
            
        }
        
        let height = ScreenSize.SCREEN_HEIGHT/4 - 40
        
        configureCollectionView(item: data, collectionView: collectionView, cellIdentifier: [R.reuseIdentifier.exploreCategoryCollectionViewCell.identifier], screenType: .generic, cellSize: CGSize(width: UIScreen.main.bounds.width/3  , height: height ), lineSpacing: 0, interItemSpace: 0 , edgeInsetsMake: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), sectionHeaderHeight: CGSize(width: 0, height: 0))
        collectionView.reloadData()
    }
    
    
    
}
