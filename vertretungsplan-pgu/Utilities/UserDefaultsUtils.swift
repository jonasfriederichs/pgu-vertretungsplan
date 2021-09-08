//
//  UserDefaultsUtils.swift
//  UserDefaultsUtils
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import Foundation


struct UserDefaultsUtils {
    
    let UserDefault = UserDefaults.standard
    
    func setLogIn(status: Bool) {
        
        UserDefault.set(status, forKey: "loggedIn")
        
    }
    
}
