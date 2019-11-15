//
//  PhoneNumberViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class PhoneNumberViewController: UIViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var textFieldPhone: FPNTextField!
    @IBOutlet weak var labelHeader: UILabel!
    
    //MARK::- PROPERTIES
    var phoneVm = PhoneVerificationVM()
    
    //MARK::- PROPERTIES
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
        
    }
    
    //MARK::- VIEW CYCLE
    
    func onLoad(){
        setUpPhoneNumberField()
        labelHeader?.text =  "Hi! " + /phoneVm.user?.name + " signup in 3 easy steps"
    }
    
    
    //MARK::- ACTIONS
    @IBAction func btnActionNext(_ sender: UIButton) {
        phoneVm.user?.mobileNo = textFieldPhone.getRawPhoneNumber()
        phoneVm.user?.countryCode = textFieldPhone.selectedCountry?.phoneCode
        phoneVm.registerMobile()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        popVC()
    }
}


extension PhoneNumberViewController : FPNTextFieldDelegate {
    
    
    //configuring textfiled
    
    func setUpPhoneNumberField(){
        textFieldPhone.parentViewController = self
        textFieldPhone.delegate = self
        textFieldPhone.flagButtonSize = CGSize(width: 56, height: 48)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
//        textField.rightViewMode = .always
//        textField.rightView = UIImageView(image: isValid ? R.image.ic_check() : R.image.ic_cross())
        btnNext.isEnabled = isValid
        btnNext.alpha = isValid ? 1 : 0.7
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    
}
