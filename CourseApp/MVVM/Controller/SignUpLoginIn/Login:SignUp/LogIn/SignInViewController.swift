//
//  SignInViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: BaseViewController {
    
    //MARK::- OUTLETS
    
    //tag - 0 is for student, tag 1 is for instructor in case of outlet collections
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnHideShowPassword: UIButton!
    @IBOutlet weak var viewStudent: UIView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet var imageSelectedUserInstructor: [UIImageView]!
    @IBOutlet var labelSelectedUser: [UILabel]!
    @IBOutlet weak var viewInstructor: UIView!
    @IBOutlet weak var labelReset: UILabel!
    @IBOutlet weak var labelForgetPassword: UILabel!
    @IBOutlet weak var labelRememberUser: UILabel!
    @IBOutlet weak var imageChecked: UIImageView!
    @IBOutlet weak var textFieldEmailMb: UITextField!
    @IBOutlet weak var viewFb: UIView!
    @IBOutlet weak var viewGoogle: UIView!
    @IBOutlet weak var viewLinkedIn: UIView!
    
    //MARK::- PROPERTIES
    var signInVM = SignInViewModal()
    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
        
    }
    
    func onLoad(){
        
        setGoogleSignInDelegates()
        textFieldPassword.delegate = self
        textFieldEmailMb.delegate = self
        updateUserTypeSelection(for: 0)
        
        labelReset.addTapGesture { [weak self] (gesture) in
            self?.moveToForgetPassword()
        }
        
        imageChecked.addTapGesture { [weak self] (gesture) in
            self?.rememberUser()
        }
        
        labelRememberUser.addTapGesture { [weak self] (gesture) in
            self?.rememberUser()
        }
        
        labelForgetPassword.addTapGesture { [weak self] (gesture) in
            self?.moveToForgetPassword()
        }
        
        viewStudent.addTapGesture { [weak self] (gesture) in
            self?.updateUserTypeSelection(for: 0)
        }
        
        viewInstructor.addTapGesture { [weak self] (gesture) in
            self?.updateUserTypeSelection(for: 1)
        }
        
        viewFb.addTapGesture { [weak self] (gesture) in
            self?.facebookLogin(isLogin: true , completion : { user in
                print(/user?.email)
            })
        }
        
        viewGoogle.addTapGesture { [weak self] (gesture) in
            self?.view.isUserInteractionEnabled = false
            GIDSignIn.sharedInstance().signIn()
        }
        
        
        viewLinkedIn.addTapGesture { [weak self] (gesture) in
            
        }
        
    }
    
    
    
    func rememberUser(){
        
        //tag 0 -> remember user is disabled ; tag 1 -> remember user is enabled
        labelRememberUser?.tag = /labelRememberUser?.tag == 0 ? 1 : 0
        imageChecked?.image = imageChecked?.image == R.image.ic_unchecked() ? R.image.ic_chaked() : R.image.ic_unchecked()
    }
    
    
    
    func moveToForgetPassword(){
        guard let vc = R.storyboard.main.forgotPasswordViewController() else { return
        }
        pushVC(vc)
    }
    
    func updateUserTypeSelection(for userTag: Int){
        //tag - 0 is for student, tag 1 is for instructor in case of outlet collections
        imageSelectedUserInstructor.first?.isHidden = userTag != 0
        imageSelectedUserInstructor.last?.isHidden = userTag == 0
        labelSelectedUser.first?.font = userTag == 0 ?  R.font.robotoBold(size: 12) : R.font.robotoRegular(size: 12)
        labelSelectedUser.last?.font = userTag != 0 ?  R.font.robotoBold(size: 12) : R.font.robotoRegular(size: 12)
    }
    
    //MARK::- FUNCTIONS
    
    //MARK::- ACTIONS
    
    
    @IBAction func btnActionSignIn(_ sender: UIButton) {
        signInVM.user = User(email: /textFieldEmailMb.text?.isEmail ? /textFieldEmailMb.text : "", phoneNumb: /textFieldEmailMb.text?.isEmail ? "" : /textFieldEmailMb.text, password: /textFieldPassword.text, userType: /labelRememberUser.tag)
        signInVM.login()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func btnActionSignup(_ sender: UIButton) {
        guard let vc = R.storyboard.main.signUpViewController() else { return }
        pushVc(vc: vc)
    }
    
    @IBAction func btnActionHideShowPassword(_ sender: UIButton) {
        btnHideShowPassword.isSelected = btnHideShowPassword.isSelected.toggleVal()
        textFieldPassword.isSecureTextEntry = !btnHideShowPassword.isSelected
    }
    
}

extension SignInViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField){
        btnSignIn?.isEnabled = !(/textFieldEmailMb.text?.isBlank || /textFieldEmailMb.text?.isEmpty || /textFieldPassword.text?.isBlank || /textFieldPassword.text?.isEmpty)
        btnSignIn?.alpha = (/textFieldEmailMb.text?.isBlank || /textFieldEmailMb.text?.isEmpty || /textFieldPassword.text?.isBlank || /textFieldPassword.text?.isEmpty) ? 0.7 : 1.0
    }
}
