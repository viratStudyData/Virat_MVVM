//
//  SignInViewModal.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 24/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class SignInViewModal: NSObject {
    
    var user: User?
    
    
    func signInWithCredentials(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
        //api for signin
    }
    
    func navigateToStudentDashboard(){
        guard let vc = R.storyboard.userDashBoard.courseUserTabViewController() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func navigateToInstructorDashboard(){
        guard let vc = R.storyboard.userDashBoard.courseUserTabViewController() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
}

//MARK::- API HANDLER
extension SignInViewModal {
    
    func login() {
        LoginEP.login(emailOrMobileNumber: /user?.email == "" ? /user?.mobileNo : /user?.email , logginAs: /user?.userType == 1 ? "instructor" : "student" , password: /user?.password ).request(success: { [weak self] (data) in
            guard let user = data as? UserData else { return }
            UserPreference.shared.user = user
            self?.handleNavigation(user: UserPreference.shared.user?.data)
            
        }) { (error) in
            print(error)
        }
    }
    
    func handleNavigation(user: User?){
        if /user?.isMobileNoVerified {
            /user?.userType == 0 ? navigateToStudentDashboard() : navigateToInstructorDashboard()
        }else{
            guard let vc = R.storyboard.main.phoneNumberViewController() else { return }
            vc.phoneVm = PhoneVerificationVM(user: user)
            UIApplication.topViewController()?.pushVC(vc)
        }
    }
}

