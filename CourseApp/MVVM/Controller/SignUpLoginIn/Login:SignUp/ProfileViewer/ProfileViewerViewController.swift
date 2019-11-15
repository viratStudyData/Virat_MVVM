//
//  ProfileViewerViewController.swift
//  CourseApp
//
//  Created by Mac_Mini17 on 18/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ProfileViewerViewController: BaseViewController {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var imageMaleSelection: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewFemale: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var viewMale: UIView!
    @IBOutlet weak var imageFemaleSelection: UIImageView!
    
    //MARK::- PROPERTIES
    var profileVm = ProfileViewerViewModal()
    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
    
    //MARK::- FUNCTIONS
    
    func onLoad(){
        labelName?.text = /profileVm.user?.firstName + " " + /profileVm.user?.lastName
        updateSelectedGender(for: true)
    }
    
    func binding(){
        viewMale.addTapGesture { [weak self] (tap) in
            self?.updateSelectedGender(for: true)
        }
        
        viewFemale.addTapGesture { [weak self] (tap) in
            self?.updateSelectedGender(for: false)
        }
        
        imageUser.addTapGesture { [weak self] (tap) in
            self?.mediaPicker?.showImagePicker { [weak self](image) in
                self?.imageUser.image = image
            }
        }
    }
    
    func updateSelectedGender(for male: Bool ){
        imageMaleSelection?.tag = /imageMaleSelection?.tag == 0 ? 1 : 0
        imageMaleSelection?.image = /imageMaleSelection?.tag == 1 ? R.image.ic_chaked() : R.image.ic_unchecked()
        
        imageFemaleSelection?.tag = /imageFemaleSelection?.tag == 0 ? 1 : 0
        imageFemaleSelection?.image = imageFemaleSelection?.tag == 1 ? R.image.ic_chaked() : R.image.ic_unchecked()
    }
    
    //MARK::- ACTIONS
    
    
    @IBAction func btnActionSkip(_ sender: UIButton) {
        profileVm.navigateToDashboard()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.popVC()
    }
    
    @IBAction func btnActionDOB(_ sender: UIButton) {
        datePickerTapped(title: "Select Date of Birth" , selectedStringFormat: "dd/MM/yyyy") { [ weak self] (date, formatteddate) in
            self?.profileVm.user?.dob = date
            sender.setTitle(formatteddate, for: .normal)
        }
    }
    
    @IBAction func btnActionNext(_ sender: UIButton) {
        profileVm.user?.profileImage = imageUser.image?.jpegData(compressionQuality: 0)
        profileVm.user?.isMale = imageMaleSelection?.tag == 1
        profileVm.updateProfileDetails()
    }
    
    
    
}
