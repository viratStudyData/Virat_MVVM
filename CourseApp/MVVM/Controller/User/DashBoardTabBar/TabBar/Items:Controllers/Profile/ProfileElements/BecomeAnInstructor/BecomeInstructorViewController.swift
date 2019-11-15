//
//  BecomeInstructorViewController.swift
//  CourseApp
//
//  Created by Harminder on 01/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class BecomeInstructorViewController: BaseViewController {
    
    //MARK::- OUTLETS
    
    
    @IBOutlet weak var collectionViewInstructors: UICollectionView!{
        didSet {
            collectionViewInstructors.registerXIB(R.reuseIdentifier.instructorListingCollectionViewCell.identifier)
        }
    }
    @IBOutlet weak var collectionViewInstructorReviews: UICollectionView!{
        didSet {
            collectionViewInstructorReviews.registerXIB(R.reuseIdentifier.instructorViewsCollectionViewCell.identifier)
        }
    }
    
    //MARK::- PROPERTIES
    
    
    
    //MARK::- VIEW CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }
    
    //MARK::- FUNCTIONS
    
    func onLoad(){
        //configure instructor listing collection
        
        cellForRowAt = { (cell,item,indexpath) in
            print(item)
            
        }
        didSelectRow = { (indexpath) in
            print(indexpath)
        }
        configureCollectionView(item: ["1","2","","",""], collectionView: collectionViewInstructors, cellIdentifier: [R.reuseIdentifier.instructorListingCollectionViewCell.identifier], screenType: .generic, cellSize: CGSize(width: (UIScreen.main.bounds.width/2)  , height:  ScreenSize.SCREEN_HEIGHT/9.5 ), lineSpacing: 0, interItemSpace: 16 , edgeInsetsMake: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), sectionHeaderHeight: CGSize(width: 0, height: 0))
        
        cellForRowAt2 = { (cell,item,indexpath) in
            print(item)
        }
        configureCollectionView2(item: ["a","b",""], collectionView: collectionViewInstructorReviews , cellIdentifier: [R.reuseIdentifier.instructorViewsCollectionViewCell.identifier], screenType: .generic, cellSize: CGSize(width: ScreenSize.SCREEN_WIDTH / 1.5  , height: ScreenSize.SCREEN_HEIGHT/9.5), lineSpacing: 0, interItemSpace: 0, edgeInsetsMake: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), sectionHeaderHeight: CGSize(width: 0, height: 0))
        
    }
    
    //MARK::- BUTTON ACTIONS
    
    @IBAction func btnActionGetStarted(_ sender: UIButton) {
        guard let vc = R.storyboard.instructorDashboard.instHomeVC() else { return }
        pushVC(vc)
    }
    
}
