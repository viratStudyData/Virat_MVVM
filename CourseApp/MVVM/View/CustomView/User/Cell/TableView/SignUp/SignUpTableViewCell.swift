//
//  SignUpTableViewCell.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

protocol DelegateUpdateValue: class {
    func delegateUpdateValue(tag: Int , value: String , isPicker: Bool)
    func delegateIsSecureTextEntry(isSecureTextEntry: Bool)
}

class SignUpTableViewCell: UITableViewCell {
    
    //MARK::- OUTLETS
    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField?.delegate = self
        }
    }
    @IBOutlet weak var btnPicker: UIButton!
    @IBOutlet weak var imageDropdown: UIImageView!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    
    //MARK:- PROPERIES
    var isSecureTextEntry = true
    var signUpKeys: SignUpKeys?{
        didSet{
            textField?.placeholder = /signUpKeys?.name
            textField?.tag = /signUpKeys?.tag
            btnPicker?.tag = /signUpKeys?.tag
            textField?.text = /signUpKeys?.value
            imageDropdown?.isHidden = true
            btnPicker?.isHidden = true
//            imageDropdown?.isHidden = !(/signUpKeys?.tag == 2 || /signUpKeys?.tag == 3 || /signUpKeys?.tag == 4 || /signUpKeys?.tag == 5)
//            textField?.isEnabled = !(/signUpKeys?.tag == 2 || /signUpKeys?.tag == 3 || /signUpKeys?.tag == 4 || /signUpKeys?.tag == 5)
//            btnPicker.isHidden = !(/signUpKeys?.tag == 2 || /signUpKeys?.tag == 3 || /signUpKeys?.tag == 4 || /signUpKeys?.tag == 5)
            btnShowHidePassword.isHidden = /signUpKeys?.tag != 3
            textField?.isSecureTextEntry = /signUpKeys?.tag == 3 ? isSecureTextEntry : false
            
        }
    }
    weak var delegate:DelegateUpdateValue?
    var signupVM : SignUpTableCellViewModal?
    
    //MARK::- FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnShowHidePassword(_ sender: UIButton) {
        btnShowHidePassword.isSelected = btnShowHidePassword.isSelected.toggleVal()
        textField.isSecureTextEntry = !btnShowHidePassword.isSelected
        delegate?.delegateIsSecureTextEntry(isSecureTextEntry: !btnShowHidePassword.isSelected)
    }
    
    @IBAction func btnActionPicker(_ sender: UIButton) {
        self.endEditing(true)
        delegate?.delegateUpdateValue(tag: btnPicker.tag, value: "" , isPicker: true)
    }
    
}


extension SignUpTableViewCell : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason){
        delegate?.delegateUpdateValue(tag: textField.tag, value: /textField.text, isPicker: false)
    }
    
}
