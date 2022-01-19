//
//  UserDefaultsUtils.swift
//  UserDefaultsUtils
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import Foundation

struct UserDefaultStrings {
    
    static let loggedIn = "loggedIn"
    
    static let isTeacher = "isTeacher"
    
    static let className = "className"
    
}


struct UserDefaultsUtils {
    
    let UserDefault = UserDefaults.standard
    
    func setLogIn(status: Bool, role: Role) {
        
        UserDefault.set(status, forKey: UserDefaultStrings.loggedIn)
        
        guard status != false else { return }
        
        if role == .teacher { UserDefault.set(true, forKey: UserDefaultStrings.isTeacher) }
        else if role == .student { UserDefault.set(false, forKey: UserDefaultStrings.isTeacher) }
         
    }
    
    func setClassName(name: String) {
        
        print("New className in defaults set: \(name)")
        UserDefault.set(name, forKey: UserDefaultStrings.className)
        
    }
    
    func getDefaults() -> (isLoggedIn: Bool, role: Role, className: String) {
        
        let isLoggedIn = UserDefault.bool(forKey: UserDefaultStrings.loggedIn)
        
        let isTeacher = UserDefault.bool(forKey: UserDefaultStrings.isTeacher)
        
        let className = UserDefault.string(forKey: UserDefaultStrings.className) ?? ""
        
        let role: Role = isTeacher ? .teacher : .student
        
        return (isLoggedIn, role, className)
        
        
    }
    
}
