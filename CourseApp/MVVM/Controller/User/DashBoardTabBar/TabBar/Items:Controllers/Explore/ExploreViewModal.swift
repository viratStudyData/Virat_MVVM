//
//  ExploreViewModal.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 12/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ExploreViewModal: NSObject {
    
    var exploreData : HomeData?
    var explores = ["EXPLORE CATEGORIES" , "BEST SELLING" , "INSTRUCTORS" , "FEATURED COURSES" , "TRENDING COURSES" , "UPCOMING COURSES"]
    
}

//MARK::- API HANDLER
extension ExploreViewModal {
    
    func exploreHome(completionHandler: @escaping () -> Void){
        
        if UserPreference.shared.home != nil{
            exploreData = UserPreference.shared.home
            completionHandler()
            return
        }
        
        HomeEndPoint.homeDetails.request(success: { [weak self] (data) in
            guard let explore = data as? HomeData else { return }
            self?.exploreData = explore
            UserPreference.shared.home = self?.exploreData
            completionHandler()
        })
        
    }
    
}
