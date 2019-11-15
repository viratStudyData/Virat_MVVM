//
//  InstDashboardVC.swift
//  CourseApp
//
//  Created by Apple on 30/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class InstDashboardVC: CreateCourseBaseVC {
    
    //MARK::- OUTLETS
    @IBOutlet weak var viewContainer: UIView!
    
    //MARK::- PROPERTIES
    var controllersArray  = [CourseCreationVC.instanceFromNip(storyboard: .main)]

    
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
     //MARK::- FUNCTIONS
 
}
