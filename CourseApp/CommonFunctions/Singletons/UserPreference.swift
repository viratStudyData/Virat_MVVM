//
//  UserPreference.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import Foundation

class UserPreference {
    
    let DEFAULTS_KEY = "CourseUserAppInfo"
    let DEFAULTS_KEYHOME = "CourseUserAppHomeInfo"
    
    static let shared = UserPreference()
    
    var user : UserData? {
        get{
            return fetchData()
        }
        set{
            if let value = newValue {
                saveData(value)
            } else {
                removeData()
            }
        }
    }
    
    var home : HomeData? {
        get{
            return fetchHomeData()
        }
        set{
            if let value = newValue {
                saveHomeData(value)
            } else {
                removeData()
            }
        }
    }
    
    func saveData(_ value: UserData) {
        guard let data = JSONHelper<UserData>().getData(model: value) else {
            removeData()
            return
        }
        UserDefaults.standard.set(data, forKey: DEFAULTS_KEY)
    }
    
    func fetchData() -> UserData? {
        guard let data = UserDefaults.standard.data(forKey: DEFAULTS_KEY) else {
            return nil
        }
        return JSONHelper<UserData>().getCodableModel(data: data)
    }
    
    func removeData() {
        UserDefaults.standard.removeObject(forKey: DEFAULTS_KEY)
    }
    
    
    func saveHomeData(_ value: HomeData) {
        guard let data = JSONHelper<HomeData>().getData(model: value) else {
            removeData()
            return
        }
        UserDefaults.standard.set(data, forKey: DEFAULTS_KEYHOME)
    }
    
    func fetchHomeData() -> HomeData? {
        guard let data = UserDefaults.standard.data(forKey: DEFAULTS_KEYHOME) else {
            return nil
        }
        return JSONHelper<HomeData>().getCodableModel(data: data)
    }
    
}

