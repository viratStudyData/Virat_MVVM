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

struct ScreenSize {
  static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
  static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
  static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
  static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
  static let SCALE = UIScreen.main.scale
    static let homeHeadingHeight = UIScreen.main.scale
}
