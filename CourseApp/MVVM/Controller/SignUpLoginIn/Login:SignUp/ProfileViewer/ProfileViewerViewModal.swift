//
//  ProfileViewerViewModal.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 24/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ProfileViewerViewModal: NSObject {
    
    //MARK::- PROPERTIES
    var user: User?
    
    //MARK::- INITIALIZERS
    override init() {
        super.init()
    }
    
    init(user: User?){
        self.user?.isMale = true
        self.user = user
    }
    
    //MARK:::- FUNCTIONS
    
    func navigateToDashboard(){
        guard let vc = R.storyboard.userDashBoard.courseUserTabViewController() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
}

//MARK::- API HANDLER
extension ProfileViewerViewModal {
    
    func updateProfileDetails() {
        LoginEP.appFinalStep(id: /user?._id, gender: /user?.isMale ? "male" : "female", dob: /user?.dob?.changeFormat(newFormat: "yyyy-MM-dd")).request(success: { [weak self] (data) in
            guard let user = data as? UserData else { return }
            let token = UserPreference.shared.user?.data?.accessToken
            user.data?.accessToken = token
            UserPreference.shared.user = user
            self?.navigateToDashboard()
        }) { (error) in
            print(error)
        }
    }
}
