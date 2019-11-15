//
//  SignUpViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 17/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignUpViewController: BaseViewController {
    
    //MARK::- TABLEVIEW
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview?.delegate = self
            tableview?.dataSource = self
        }
    }
    @IBOutlet weak var viewFb: UIView!
    @IBOutlet weak var viewGoogle: UIView!
    @IBOutlet weak var viewLinkedIn: UIView!
    
    //MARK::- PROPERTIES
    var signupVM = SignUpViewModal()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
        binding()
    }
    
    //MARK::- FUNCTIONS
    func binding(){
        signupVM.validateKeys = { [weak self] isValid in
            print(isValid)
            self?.btnNext.isEnabled = isValid
            self?.btnNext.alpha = isValid ? 1 : 0.7
        }
        
        signupVM.selectedCZPickerItem = { [weak self] item , tag in
            self?.tableview.reloadData()
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
    
    func onLoad(){
        tableview.reloadData()
    }
    
    
    
    //MARK::- ACTIONS
    @IBAction func btnActionSignUp(_ sender: UIButton) {
        signupVM.signUp()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        popVC()
    }
    
}


extension  SignUpViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signupVM.signUpKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : SignUpTableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.signUpTableViewCell , for: indexPath)  else { return  UITableViewCell() }
        cell.isExclusiveTouch = true
        cell.delegate = self
        cell.isSecureTextEntry = /signupVM.isSecureTextEntry
        cell.signUpKeys = signupVM.signUpKeys[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}

extension SignUpViewController : DelegateUpdateValue {
    
    func delegateIsSecureTextEntry(isSecureTextEntry: Bool) {
        signupVM.isSecureTextEntry = isSecureTextEntry
    }
    
    func delegateUpdateValue(tag: Int , value: String, isPicker: Bool){
        if /isPicker{
            switch tag {
            case 2://country
                break
            case 3://language
                break
            case 4://occupation
                break
            case 5://education
                break
            default:
                break
            }
            signupVM.configurePicker(for: tag)
        }else{
            signupVM.updateValue(tag: tag , value: value)
        }
        
    }
}
