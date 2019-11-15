//
//  ForgotViewModal.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 11/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ForgotViewModal: NSObject {

    var input: String?
    
    func forgotPassword(completionHandler: @escaping (Bool) -> Void) {
        LoginEP.forgotPassword(input: /input).request(success: { [weak self] (data) in
           completionHandler(true)
        }) { (error) in
            print(error)
        }
    }
    
}
