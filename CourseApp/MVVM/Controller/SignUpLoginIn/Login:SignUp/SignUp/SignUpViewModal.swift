//
//  SignUpViewModal.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import CZPicker

class SignUpViewModal : NSObject {
    
    //MARK:- PROPERTIES
    var signUpKeys = [SignUpKeys]()
    var validateKeys: (( _ validate: Bool) -> ())?
    var selectedCZPickerItem: (( _ item: CZPickerItems, _ tag: Int) -> ())?
    var textFieldsPlaceHolders = [ "First name" , "Last name" , "Enter your email ID" , "Create password" ]
    //    var textFieldsPlaceHolders = [ "First name" , "Last name" , "Country" , "Language" , "Occupation" , "Education" , "Enter your email ID" , "Create password" ]
    var picker = CZPickerView(headerTitle: "Header", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    //array for CZPicker
    lazy var pickerItems = [CZPickerItems]()
    var isSecureTextEntry = true
    
    //MARK::- FUNCTIONS
    
    override init() {
        super.init()
        gatherSignUpKeys()
    }
    
    func gatherSignUpKeys() {
        for (index,placeholder) in textFieldsPlaceHolders.enumerated() {
            signUpKeys.append(SignUpKeys(name: placeholder, value: "", tag: index))
        }
    }
    
    func updateValue(tag: Int , value: String){
        signUpKeys[tag].value = value
        validateKeys?(validateValues())
    }
    
    func validateValues() -> Bool{
        var isEnable = true
        signUpKeys.forEach { (signUp) in
            if (/signUp.value?.isEmpty) || (/signUp.value?.isBlank) {
                isEnable = false
            }
        }
        if !(/signUpKeys[2].value?.isEmail){
            isEnable = false
        }
        return isEnable
    }
    
    //MARK::- NAVIGATIONS
    func moveToPhoneNum(retrievedUserId: String){
        guard let vc = R.storyboard.main.phoneNumberViewController() else { return }
        vc.phoneVm = PhoneVerificationVM(user: User(email: /signUpKeys[2].value, firstName: /signUpKeys.first?.value, password: /signUpKeys.last?.value, lastName: /signUpKeys[1].value , userId: /retrievedUserId ))
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    
}


extension SignUpViewModal : CZPickerViewDelegate, CZPickerViewDataSource {
    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        pickerItems.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return /pickerItems[row].name
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        signUpKeys[/picker?.tag].value = pickerItems[row].name
        selectedCZPickerItem?(pickerItems[row] , /picker?.tag)
        validateKeys?(validateValues())
    }
    
    
    func configurePicker(for tag:Int){
        picker?.tag = tag
        pickerItems.append(CZPickerItems(name: "abc", id: "1"))
        pickerItems.append(CZPickerItems(name: "def", id: "2"))
        
        
        picker?.checkmarkColor = R.color.colorHeadings()
        picker?.cancelButtonBackgroundColor = R.color.colorTheme()
        picker?.cancelButtonNormalColor = R.color.colorThemeHeadings()
        picker?.confirmButtonBackgroundColor = R.color.colorTheme()
        picker?.confirmButtonNormalColor = R.color.colorThemeHeadings()
        picker?.headerBackgroundColor = R.color.colorTheme()
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.show()
    }
    
}

//MARK::- API HANDLER
extension SignUpViewModal {
    
    func signUp() {
        LoginEP.appSignUp(firstName: /signUpKeys.first?.value , lastName: /signUpKeys[1].value , email: /signUpKeys[2].value , password:  /signUpKeys.last?.value).request(success: { [weak self] (data) in
            guard let user = data as? UserData else { return }
            self?.moveToPhoneNum(retrievedUserId: /user.data?._id)
        }) { (error) in
            print(error)
        }
    }
}


class CZPickerItems{
    
    var name:String?
    var id: String?
    
    init(name:String? , id: String?) {
        self.name = name
        self.id = id
    }
    
}


class SignUpKeys{
    
    var name: String?
    var value: String?
    var tag:Int?
    
    init(name: String , value: String , tag: Int ){
        self.name = name
        self.value = value
        self.tag = tag
    }
    
}
