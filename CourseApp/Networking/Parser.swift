//
//  Parser.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    
    func parseModel(data: Data) -> Any? {
        
        print(data)
        switch self {
        case is LoginEP:
            let endpoint = self as! LoginEP
            switch endpoint {
            case .resendOtp(_) , .logout , .forgotPassword(_):
                return nil
            case .appFinalStep(_) , .login(_):
                return JSONHelper<UserData>().getCodableModel(data: data)
            case .otpVerify(_):
                return JSONHelper<UserData>().getCodableModel(data: data)
            case .appSignUp(_) , .updateMobileNo(_) :
                return JSONHelper<UserData>().getCodableModel(data: data)
                
            }
            
            
        case is HomeEndPoint:
            let endpoint = self as! HomeEndPoint
            switch endpoint {
            case .homeDetails:
                return JSONHelper<HomeData>().getCodableModel(data: data)
            }
            
        default:
            return nil
        }
        
        
    }
}
