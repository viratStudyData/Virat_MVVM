//
//  ForgotPasswordViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 11/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var textFieldEmail: UITextField!{
        didSet{
            textFieldEmail?.delegate  = self
        }
    }
    @IBOutlet weak var btnNext: UIButton!
    
    //MARK::- PROPERTIES
    var forgotVm = ForgotViewModal()
    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK::- ACTIONS
    @IBAction func btnAcctionNext(_ sender: UIButton) {
        forgotVm.input = /textFieldEmail?.text
        forgotVm.forgotPassword { [weak self] (status) in
            if status{
                Toast.shared.showAlert(type: .success, message: "Password sent to registered email or phone number successfully.")
                self?.popVC()
            }
        }
    }
    
}

extension ForgotPasswordViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField){
        btnNext?.isEnabled = !(/textFieldEmail.text?.isBlank || /textFieldEmail.text?.isEmpty )
        
    }
}

