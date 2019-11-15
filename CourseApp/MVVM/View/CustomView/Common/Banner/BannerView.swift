//
//  BannerView.swift
//  CourseApp
//
//  Created by Harminder on 03/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class BannerView: UIView {
    
    //MARK::- OUTLETS
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.registerXIB(R.reuseIdentifier.bannerCollectionViewCell.identifier)
        }
    }
    
    //MARK::- PROPERTIES
    
    var item = [Any](){
        didSet{
            configureCollectionView(item: item)
        }
    }
    
    var collectionViewDataSource : CollectionViewDataSource?
    
    //MARK::- CONFIGURE COLLECTIONVIEW
    
    func configureCollectionView(item: [Any]){
        collectionViewDataSource = CollectionViewDataSource(items: item , collectionView: collectionView, cellIdentifier: /R.reuseIdentifier.bannerCollectionViewCell.identifier , headerIdentifier: "", cellHeight: ScreenSize.SCREEN_HEIGHT * 0.2 , cellWidth: ScreenSize.SCREEN_WIDTH , minimumLineSpacing: 0 , minimumInteritemSpacing: 0 , edgeInsetsMake:UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 ), sectionHeaderHeight:  CGSize.zero)
        collectionViewDataSource?.configureCellBlock = { (cell,item,indexpath) in
            (cell as? BannerCollectionViewCell)?.item = item
        }
        collectionViewDataSource?.aRowSelectedListener = { indexpath in
            
        }
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDataSource
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
    }
    
}
