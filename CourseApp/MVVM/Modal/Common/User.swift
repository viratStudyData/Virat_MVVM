//
//  User.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 24/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import Foundation

class UserData: Codable {
    
    var success: Bool?
    var status: Int?
    var message: String?
    var data: User?
    
}

class User: Codable {
    
    var _id:String?
    var name : String?
    var accessToken: String?
    var firstName:String?
    var lastName:String?
    var mobileNo:String?
    var countryCode:String?
    var thumbnailImage:String?
    var originalImage:String?
    var email:String?
    var fullPhone:String?
    var otp:String?
    var facebookId: String?
    var googleId: String?
    var isVerified: Bool?
    var isPasswordExist : Bool?
    var password: String?
    var isMale: Bool?
    var isMobileNoVerified: Bool?
    var userName: String?
    var dateOfBirth : String?
    var gender : String?
    
    
    
    
    var dob: Date?
    
    var userType: Int?
    var profileImage: Data?
    
    
//    override init() {
//        super.init()
//    }
    
    init(email:String? , phoneNumb:String? , password: String , userType: Int?) {
        self.email = email
        self.mobileNo = phoneNumb
        self.password = password
        self.userType = userType
    }

    init(email:String? , firstName:String? , password: String , lastName: String? , userId: String) {
        self.email = email
        self.firstName = firstName
        self.password = password
        self.lastName = lastName
        self.name = /firstName + " " + /lastName
        self._id = /userId
    }
    
}



