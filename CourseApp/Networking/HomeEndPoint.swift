//
//  HomeEndPoint.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 13/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import Foundation
import Moya

enum HomeEndPoint {
    case homeDetails
    
}

extension HomeEndPoint: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return URL(string: APIConstant.basePath)!
    }
    
    var path: String {
        switch self {
        case .homeDetails:
            return APIConstant.appHomePage
            
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .homeDetails:
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
        case .homeDetails:
            return [:]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .homeDetails:
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
