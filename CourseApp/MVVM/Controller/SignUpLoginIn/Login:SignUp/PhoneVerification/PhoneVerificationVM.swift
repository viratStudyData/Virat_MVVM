//
//  PhoneVerificationVM.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class PhoneVerificationVM: NSObject {

    //MARK::- PROPERTIES
    var user: User?
    
    //MARK::- INITIALIZERS
    override init() {
        super.init()
    }
    
    init(user: User?){
        self.user = user
    }
    
    //MARK::- FUNCTIONS
    func moveToProfileViewer(){
        print(user?.otp)
        guard let vc = R.storyboard.main.profileViewerViewController() else { return }
        vc.profileVm = ProfileViewerViewModal(user: user)
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func moveToOTPVerification(){
        guard let vc = R.storyboard.main.otpVerificationViewController() else { return }
        vc.phoneVM.user = self.user
        UIApplication.topViewController()?.pushVC(vc)
    }
    
}

//MARK::- API HANDLER
extension PhoneVerificationVM {
    
    func registerMobile(){
        LoginEP.updateMobileNo(id: /user?._id, countryCode: /user?.countryCode, mobileNo: /user?.mobileNo).request(success: { [weak self] (data) in
            guard let user = data as? UserData else { return }
            self?.moveToOTPVerification()
        }) { (error) in
            print(error)
        }
    }
    
    func verifyOtp(){
        LoginEP.otpVerify(id: /user?._id, otp: /user?.otp).request(success: { [weak self] (data) in
            guard let user = data as? UserData else { return }
            UserPreference.shared.user = user
            self?.moveToProfileViewer()
        }) { (error) in
            print(error)
        }
    }
    
    func resendOtp(completionHandler: @escaping (Bool) -> Void){
           LoginEP.resendOtp(id: /user?._id).request(success: { [weak self] (data) in
//            Toast.shared.showAlert(type: .success, message: /(data as? UserData)?.message)
            completionHandler(true)
           }) { (error) in
               print(error)
           }
       }
    
}
