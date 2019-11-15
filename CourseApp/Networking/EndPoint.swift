//
//  EndPoint.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import Foundation
import Moya

enum LoginEP {
    case appSignUp(firstName:String? , lastName:String? , email:String? , password: String?)
    case login(emailOrMobileNumber:String? , logginAs:String? , password:String?)
    case updateMobileNo(id:String? , countryCode:String? , mobileNo:String? )
    case otpVerify(id:String? , otp:String?  )
    case resendOtp(id:String?)
    case forgotPassword(input:String?)
    case logout
    case appFinalStep(id:String? , gender:String? , dob:String?)
}

extension LoginEP: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return URL(string: APIConstant.basePath)!
    }
    
    var path: String {
        switch self {
        case .logout:
            return APIConstant.logout
        case .forgotPassword(_):
            return APIConstant.forgotPassword
        case .login(_):
            return APIConstant.login
        case .appFinalStep(_):
            return APIConstant.appFinalStep
        case .resendOtp(_):
            return APIConstant.resendOtp
        case .otpVerify(_):
            return APIConstant.otpVerify
        case .updateMobileNo(_):
            return APIConstant.updateMobileNo
        case .appSignUp(_):
            return APIConstant.appSignUp
            
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .appFinalStep(_):
            return .put
        case .updateMobileNo(_):
            return .patch
        case .appSignUp(_) , .otpVerify(_) , .resendOtp(_) , .login(_) , .forgotPassword(_):
            return .post
        case .logout:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return Task.requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .logout:
            return ["Content-type": "application/json", "authorization": "bearer " + /UserPreference.shared.user?.data?.accessToken, "Accept-Language": "en"]
        default:
            return ["Content-type": "application/json", "Accept-Language": "en"]
        }
    }
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    //Custom Varaibles
    
    var parameters: [String: Any]? {
        
        switch self {
        case .forgotPassword( let input):
            return ["emailOrMobileNumber": /input ]
        case .logout:
            return [:]
            
        case .login(let emailOrMobileNumber, let logginAs, let password):
            return ["emailOrMobileNumber":/emailOrMobileNumber , "logginAs": /logginAs , "password": /password , "platform" : "ios"]
        case .appFinalStep( let id,  let gender, let  dob):
            var dict = ["id": /id ]
            if /gender != ""{
                dict["gender"] = /gender
            }
            if /dob != ""{
                dict["dateOfBirth"] =  /dob
            }
            return dict
        case .resendOtp( let id):
            return ["id": /id ]
        case .otpVerify( let id, let  otp):
            return ["id": /id , "otp" : /otp , "deviceId" : /UIDevice.current.identifierForVendor?.description , "platform" : "ios"  ]
        case .appSignUp( let firstName,  let lastName, let  email,  let password):
            return ["firstName": /firstName , "lastName" : /lastName , "email" : /email , "password" : /password , "platform" : "ios"  ]
        case .updateMobileNo( let id ,  let countryCode, let  mobileNo):
            return ["id": /id , "countryCode" : /countryCode , "mobileNo" : /mobileNo , "deviceId" : /UIDevice.current.identifierForVendor?.description , "platform" : "ios"  ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .logout:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
    
    
    var multipartBody: [MultipartFormData]? {
        switch self {
            
        default:
            return []
        }
    }
}

