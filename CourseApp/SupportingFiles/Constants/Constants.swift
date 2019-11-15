//
//  Constants.swift
//  CourseApp
//
//  Created by Apple on 21/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit



enum Languages: String {
    case english = "en"
    case arabic = "ar"
    
    var title:String {
        switch self {
        case .english: return R.string.localizedStrings.english()
        case .arabic: return R.string.localizedStrings.arabic()
        }
    }
    
    static var all:[Languages] = [.english, .arabic]
    
}
