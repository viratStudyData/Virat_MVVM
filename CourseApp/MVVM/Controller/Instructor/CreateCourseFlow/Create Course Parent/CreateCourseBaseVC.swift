//
//  CreateCourseBaseVC.swift
//  CourseApp
//
//  Created by Apple on 01/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class CreateCourseBaseVC: BaseViewController {
    
    //MARK::- PROPERTIES
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCustomTopBar()
    }
    
    //MARK::- FUNCTIONS
    
    func addCustomTopBar()  {
        
        let window = UIApplication.shared.keyWindow
        
        let topView = UIView(frame: CGRect(x: 0, y: /window?.safeAreaInsets.top, width: UIScreen.main.bounds.width, height: 44))
        self.view.addSubview(topView)
        
        let backButton = UIButton(frame: CGRect(x: 24, y: 0, width: 51, height: 40))
        backButton.setImage(#imageLiteral(resourceName: "ic_back_btn_wt"), for: .normal)
        backButton.addTarget(self, action:#selector(BackBtnClick(_:)), for: .touchUpInside)
        backButton.contentHorizontalAlignment = .left
        topView.addSubview(backButton)
        
        let menuButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 74, y: 0, width: 51, height: 40))
        menuButton.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
        menuButton.addTarget(self, action:#selector(showProfile), for: .touchUpInside)
        menuButton.contentHorizontalAlignment = .right
        topView.addSubview(menuButton)
    }
    
    @objc func showProfile()  {
        
        view.addSubview(backdropView)
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        guard let profileVC = R.storyboard.instructorDashboard.instProfileVC() else {return}
        profileVC.view.tag = 59
        profileVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        profileVC.view.roundCorners([.topLeft,.topRight], radius: 20)
        view.addSubview(profileVC.view)
        
        UIView.animate(withDuration: 0.5) {
            profileVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)

        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        backdropView.removeFromSuperview()
        
        guard let profileView = view.viewWithTag(59) else {return}
        profileView.removeFromSuperview()
    }
}

