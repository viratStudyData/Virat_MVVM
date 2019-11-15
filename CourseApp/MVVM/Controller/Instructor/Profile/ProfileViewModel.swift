//
//  ProfileViewModel.swift
//  CourseApp
//
//  Created by Apple on 04/11/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit

class ProfileViewModel: NSObject {

    //MARK::- PROPERTIES
    var iconsArray = [R.image.inst_ic_course(),R.image.ic_communication(),R.image.ic_performance(),R.image.ic_tools(),R.image.ic_resource(),R.image.ic_library()]
    var titlesArray = [R.string.localizedStrings.course(),R.string.localizedStrings.communication(),R.string.localizedStrings.performance(),R.string.localizedStrings.tools(),R.string.localizedStrings.resources(),R.string.localizedStrings.library()]
}

class Profile {
    
    //MARK::- PROPERTIES
    
    var title: String?
    var icon: UIImage?
    
    //MARK::- FUNCTIONS
    
    init(indexPath :  IndexPath ) {
        title = ProfileViewModel().titlesArray[indexPath.row]
        icon = ProfileViewModel().iconsArray[indexPath.row]
    }
    
}
