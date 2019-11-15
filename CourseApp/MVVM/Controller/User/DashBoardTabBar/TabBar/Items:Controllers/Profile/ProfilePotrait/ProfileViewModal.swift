//
//  ProfileViewModal.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 29/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class UserProfileViewModal: NSObject {
    
    var elements : [UserProfileElements] = [UserProfileElements(title: R.string.localizedStrings.myCalander(), icon: R.image.ic_profile_calendar(), desc: R.string.localizedStrings.viewYourUpcomingLiveSchedule())  , UserProfileElements(title: R.string.localizedStrings.becomeAnInstructor(), icon: R.image.ic_profile_instructor(), desc: R.string.localizedStrings.becomeAnInstructorAndEarn()) , UserProfileElements(title: R.string.localizedStrings.changeLanguage(), icon: R.image.language(), desc: "English") , UserProfileElements(title: R.string.localizedStrings.settings(), icon: R.image.ic_profile_settings(), desc: R.string.localizedStrings.manageYourAccount()) , UserProfileElements(title: R.string.localizedStrings.termsOfUse(), icon: R.image.ic_profile_terms(), desc: R.string.localizedStrings.viewTheTermsOfUsage()) , UserProfileElements(title: R.string.localizedStrings.privacyPolicy(), icon: R.image.ic_profile_privacy(), desc: R.string.localizedStrings.viewThePrivacyPolicy()) , UserProfileElements(title: R.string.localizedStrings.signOut(), icon: R.image.ic_profile_logout(), desc: R.string.localizedStrings.logoutOfYourAccount())]
    
    
}

//MARK::- APIs
extension UserProfileViewModal {
    
    func signout() {
        LoginEP.logout.request(success: { [weak self] (data) in
            UserPreference.shared.user = nil
            UIApplication.topViewController()?.navigationController?.popToRootViewController(animated: true)
        }) { (error) in
            print(error)
        }
    }
    
}

class UserProfileElements {
    
    var title: String?
    var icon: UIImage?
    var desc: String?
    
    //MARK::- INITIALIZERS
    
    init(title: String? ,icon: UIImage? , desc: String? ){
        self.title = title
        self.icon = icon
        self.desc = desc
    }
    
}
