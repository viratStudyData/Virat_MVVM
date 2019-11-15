//
//  CatQuestViewModel.swift
//  CourseApp
//
//  Created by Apple on 23/10/19.
//  Copyright © 2019 Mac_Mini17. All rights reserved.
//

import UIKit
import CZPicker

class CatQuestViewModel: NSObject {
    
    //MARK::- PROPERTIES
     var catgQuestKeys = [CatgQuestKeys]()
    let questionsArray = [R.string.localizedStrings.categoryQuestion()]
    var optionsArray = [R.string.localizedStrings.option1(),R.string.localizedStrings.option2(),R.string.localizedStrings.option3(),R.string.localizedStrings.option4()]
    
    var isQustionSelected = true
    var isOptionSelected = false
    let videoQuestionsArray = [R.string.localizedStrings.videoQuestion()]
    let videoOptionsArray = [R.string.localizedStrings.videoOption1(),R.string.localizedStrings.videoOption2(),R.string.localizedStrings.videoOption3(),R.string.localizedStrings.videoOption4()]
    
    var otherSelected = false
    var isCatSelected : Bool?
    
    var picker = CZPickerView(headerTitle: "Header", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    
    lazy var pickerItems = [CZPickerItems]()
    
    var selectedIndex : Int?
    var selectedOptIndex = [Int]()
    
    
    var validateKeys: (( _ validate: Bool) -> ())?
    //MARK::- FUNCTIONS
    
    func navigateToVideoQuestions() {
        guard let vc = R.storyboard.instructorDashboard.videoQuestionsVC() else { return }
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func navigateToDashboard() {
        guard let vc = R.storyboard.createCourse.courseCreationVC() else {return}
        UIApplication.topViewController()?.pushVC(vc)
    }
    
    func validateValues() -> Bool{
        var isEnable = true
        catgQuestKeys.forEach { (question) in
            if (/question.category?.isEmpty) || (/question.category?.isBlank) || (/question.experience?.isEmpty) || (/question.experience?.isBlank){
                isEnable = false
            }
        }
       
        return isEnable
    }
    
}

class Questions {
    
    //MARK::- PROPERTIES
    var title: String?
    var categorySelected : Bool?
    //MARK::- FUNCTIONS
    init(indexPath :  IndexPath , isCat : Bool = true) {
        categorySelected = isCat
        title = isCat ? CatQuestViewModel().questionsArray[indexPath.row] : CatQuestViewModel().videoQuestionsArray[indexPath.row]
    }
    
}

class QuestOpt {
    
    //MARK::- PROPERTIES
    var title: String?
    var index : Int?
    //MARK::- FUNCTIONS
    init(indexPath :  IndexPath  , isCat : Bool = true) {
        index = indexPath.row
        title = isCat ? CatQuestViewModel().optionsArray[indexPath.row] : CatQuestViewModel().videoOptionsArray[indexPath.row]
    }
    
}


extension CatQuestViewModel : CZPickerViewDelegate, CZPickerViewDataSource {
    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        pickerItems.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return /pickerItems[row].name
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
//        signUpKeys[/picker?.tag].value = pickerItems[row].name
//        selectedCZPickerItem?(pickerItems[row] , /picker?.tag)
//        validateKeys?(validateValues())
    }
    
    
    func configurePicker(for tag:Int = 1){
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



class CatgQuestKeys{
    
    var category: String?
    var experience: String?
    var tag:Int?
    
    init(category: String , experience: String , tag: Int ){
        self.category = category
        self.experience = experience
        self.tag = tag
    }
    
}

