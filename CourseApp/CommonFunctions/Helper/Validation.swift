//
//  Validation.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import UIKit

//MARK:- Alert Types
enum AlertType: String {
    case success = "SUCCESS"
    case apiFailure = "API_FAILURE"
    case validationFailure = "VALIDATION_FAILURE"
    
    var title: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    var color: UIColor {
        return R.color.colorCreateCourse() ?? .black
        
        //    switch self {
        //    case .validationFailure:
        //      return Color.buttonBlue.value
        //    case .apiFailure:
        //      return Color.gradient1.value
        //    case .success:
        //      return Color.success.value
        //    }
    }
}

//MARK:- Alert messages to be appeared on failure
enum AlertMessage: String {
    case EMPTY_EMAIL_PHONE = "EMPTY_EMAIL_PHONE"
    case EMPTY_EMAIL = "EMPTY_EMAIL"
    case INVALID_EMAIL = "INVALID_EMAIL"
    case INVALID_PHONE = "INVALID_PHONE"
    case INVALID_EMAIL_PHONE = "INVALID_EMAIL_PHONE"
    
    case EMPTY_PASSWORD = "EMPTY_PASSWORD"
    case EMPTY_PHONE = "EMPTY_PHONE"
    case INVALID_PASSWORD = "INVALID_PASSWORD"
    
    case EMPTY_CONFIRM_PASSWORD = "EMPTY_CONFIRM_PASSWORD"
    case INVALID_CONFIRM_PASSWORD = "INVALID_CONFIRM_PASSWORD"
    case PASSWORD_NOT_MATCH = "PASSWORD_NOT_MATCH"
    
    case EMPTY_NAME = "EMPTY_NAME"
    case INVALID_NAME = "INVALID_NAME"
    
    case EMPTY_CURRENT_PSW = "EMPTY_CURRENT_PSW"
    case EMPTY_NEW_PSW = "EMPTY_NEW_PSW"
    case INVALID_CURRENT_PSW = "INVALID_CURRENT_PSW"
    case INVALID_NEW_PSW = "INVALID_NEW_PSW"
    case EMPTY_OTP = "EMPTY_OTP"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

//MARK:- Check validation failed or not
enum Valid {
    case success
    case failure(AlertType, AlertMessage)
}

//MARK:- RegExes used to validate various things
enum RegEx: String {
    case EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" // Email
    case PASSWORD = "^.{6,100}$" // Password length 6-100
    case NAME = "^[A-Z]+[a-zA-Z]*$" // SandsHell
    case PHONE_NO = "(?!0{5,15})^[0-9]{5,15}" // PhoneNo 5-15 Digits
    case EMAIL_OR_PHONE = ""
    case All = "ANY_TEXT"
}

//MARK:- Validation Type Enum to be used with value that is to be validated when calling validate function of this class
enum ValidationType {
    case EMAIL
    case PHONE
    case EMAIL_OR_PHONE
    case NAME
    case PASSWORD
    case CONFIRM_PASSWORD
    case CURRENT_PSW
    case NEW_PSW
    case LOGIN_PSW
    case EMAIL_OR_PHONE_FORGOT_PSW
}


extension String {
    
    public var isNotBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return !trimmed.isEmpty
        }
    }
}
