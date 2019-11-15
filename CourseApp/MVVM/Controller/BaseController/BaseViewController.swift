//
//  BaseViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import GoogleSignIn

class BaseViewController: UIViewController {
    
    //MARK::- OUTLETS
    
    
    //MARK::- PROPERTIES
    var tableViewDataSource: TableViewDataSource?
    var collectionViewDataSource : CollectionViewDataSource?
    var collectionViewDataSource2 : CollectionViewDataSource?
    var cellForRowAt: ListCellConfigureBlock?
    var cellForRowAt2: ListCellConfigureBlock?
    var didSelectRow : DidSelectedRow?
    var viewForHeader: ViewForHeaderInSection?
    var viewForFooter : ViewForFooterInSection?
    var headerHeight : CGFloat = 0.0
    var willChangeIdentifier: ChangeCellIdentifier?
    var willChangeCellHeight: ChangeCellHeight?
    var mediaPicker: MediaPickerController?
    let datePicker = DatePickerDialog(
        textColor: R.color.colorHeadings() ?? UIColor.black,
        buttonColor: R.color.colorThemeHeadings() ?? UIColor.black,
        font: R.font.robotoBlack(size: 16) ?? UIFont.boldSystemFont(ofSize: 17),
        showCancelButton: true
    )
    enum ScreenTypes{
        case generic
        case explore
    }
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        mediaPicker = MediaPickerController.init(type: .imageOnly, presentingViewController: self)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK:- FUNCTIONS
    
    func changeLanguage(){
        
    }
    
    func moveToUserDashboard(){
        guard let vc = R.storyboard.userDashBoard.courseUserTabViewController() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func moveToInstructorDashboard(){
        
    }
    
    
    
    func facebookLogin(isLogin: Bool , completion : @escaping (User?) -> ()){
        
        self.view.isUserInteractionEnabled =  false
        //                indicator?.startAnimating()
        
        FacebookManager.shared.configureLoginManager(sender: self, success: { (facebook) in
            print(/facebook.email)
        }) { (error) in
            self.view.isUserInteractionEnabled =  true
            //                        self.indicator?.stopAnimating()
        }
        //        FacebookManager.shared.configureLoginManager(sender: self, success: { [weak self] (fb) in
        //            self?.user.email = /fb.email
        //            self?.user.facebookId = /fb.fbId
        //            self?.user.googleId = ""
        //            self?.user.originalImage = /fb.imageUrl
        //            self?.user.firstName = /fb.firstName
        //            self?.user.lastName = /fb.lastName
        //            self?.indicator?.stopAnimating()
        //            self?.view.isUserInteractionEnabled =  true
        //            completion(self?.user)
        //
        //        }) { [unowned self] (error) in
        //
        //        }
    }
    
    //MARK::- ACTIONS
    @IBAction func BackBtnClick(_ sender: UIButton) {
        popVC()
    }
    
    
}

//MARK::- GOOGLE SIGNIN
extension BaseViewController : UIApplicationDelegate , GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        self.view.isUserInteractionEnabled = true
        //        if (error == nil) {
        //            self.user.email = user.profile.email
        //            let fullName = /user.profile.name
        //            let components = fullName.components(separatedBy: " ")
        //            if(components.count > 0){
        //                self.indicatorG?.stopAnimating()
        //                self.view.isUserInteractionEnabled =  true
        //                self.registerVM.login(FbId: "", GId: /user.userID)
        //            }
        //        } else {
        //            self.indicatorG?.stopAnimating()
        //            print("\(error.localizedDescription)")
        //        }
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
        
        print(email)
        print(fullName)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
    }
    
    func setGoogleSignInDelegates(){
        GIDSignIn.sharedInstance().delegate = self
    }
    
    
}


extension BaseViewController {
    
    //MARK::- DATE PICKER
    func datePickerTapped(title:String , selectedStringFormat:String? ,  _ selectedDate: @escaping ((Date,String) -> ())) {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = -90
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        datePicker.show(title,
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            let formatter = DateFormatter()
                            formatter.dateFormat = /selectedStringFormat == "" ? "MM/dd/yyyy" :  /selectedStringFormat
                            if let dt = date {
                                selectedDate(dt,formatter.string(from: dt))
                            }else{
                                selectedDate(Date(),formatter.string(from: Date()))
                            }
        }
    }
    
    
}

//MARK::- CONFIGURE TABLEVIEW
extension BaseViewController {
    
    func configureTableView(item:[Any] , tableView: UITableView , cellIdentifier: [String] , screenType: ScreenTypes , rowHeight : CGFloat = 64 , sectionRows : [Int] = []){
        switch screenType {
        case .generic:
            tableViewDataSource = TableViewDataSource(items: item, height: rowHeight, tableView: tableView, cellIdentifier: /cellIdentifier.first ,sectionRows: sectionRows)
        case .explore:
            tableViewDataSource = ExploreTableViewDataSource(items: item, height: rowHeight, tableView: tableView, cellIdentifier: /cellIdentifier.first)
        }
        tableViewDataSource?.configureCellBlock = cellForRowAt
        tableViewDataSource?.aRowSelectedListener = didSelectRow
        tableViewDataSource?.viewforHeaderInSection = viewForHeader
        tableViewDataSource?.viewForFooterInSection = viewForFooter
        tableViewDataSource?.headerHeight = headerHeight
        tableViewDataSource?.willChangeIdentifier = willChangeIdentifier
        tableViewDataSource?.willChangeCellHeight = willChangeCellHeight
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        tableView.reloadData()
    }
    
    //MARK::- CONFIGURE COLLECTIONVIEW
    
    func configureCollectionView(item:[Any] , collectionView: UICollectionView , cellIdentifier: [String] , screenType: ScreenTypes , cellSize : CGSize , lineSpacing: CGFloat , interItemSpace: CGFloat , edgeInsetsMake: UIEdgeInsets? , sectionHeaderHeight: CGSize? ){
        switch screenType {
        case .generic :
            collectionViewDataSource = CollectionViewDataSource(items: item , collectionView: collectionView, cellIdentifier: /cellIdentifier.first , headerIdentifier: "", cellHeight: cellSize.height, cellWidth: cellSize.width, minimumLineSpacing: lineSpacing , minimumInteritemSpacing: interItemSpace , edgeInsetsMake: edgeInsetsMake ??  UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 ), sectionHeaderHeight: sectionHeaderHeight ?? CGSize.zero)
            collectionViewDataSource?.configureCellBlock = cellForRowAt
            collectionViewDataSource?.aRowSelectedListener = didSelectRow
            collectionView.dataSource = collectionViewDataSource
            collectionView.delegate = collectionViewDataSource
            collectionView.reloadData()
        case .explore: break
        }
    }
    
    func configureCollectionView2(item:[Any] , collectionView: UICollectionView , cellIdentifier: [String] , screenType: ScreenTypes , cellSize : CGSize , lineSpacing: CGFloat , interItemSpace: CGFloat , edgeInsetsMake: UIEdgeInsets? , sectionHeaderHeight: CGSize? ){
        switch screenType {
        case .generic:
            collectionViewDataSource2 = CollectionViewDataSource(items: item , collectionView: collectionView, cellIdentifier: /cellIdentifier.first , headerIdentifier: "", cellHeight: cellSize.height, cellWidth: cellSize.width, minimumLineSpacing: lineSpacing , minimumInteritemSpacing: interItemSpace , edgeInsetsMake: edgeInsetsMake ??  UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 ), sectionHeaderHeight: sectionHeaderHeight ?? CGSize.zero)
            collectionViewDataSource2?.configureCellBlock = cellForRowAt2
            collectionViewDataSource2?.aRowSelectedListener = didSelectRow
            collectionView.dataSource = collectionViewDataSource2
            collectionView.delegate = collectionViewDataSource2
            collectionView.reloadData()
        case .explore: break
        }
    }
    
}

