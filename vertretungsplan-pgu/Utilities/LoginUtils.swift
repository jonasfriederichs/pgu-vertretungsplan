//
//  LoginUtils.swift
//  LoginUtils
//
//  Created by Wolf Jonas Friederichs on 9/15/21.
//

import Foundation
import CryptoKit


class LoginUtils {
    
    func loginButtonPressed(username: String, password: String) -> (isLoggedIn: Bool, role: Role, error: LoginError?) {
        
        let hashedString = CryptoUtils().encryptWithSHA256(string: password)
        
        if username.lowercased() == "schueler" && hashedString == Constants.hashedPasswordSchuelerString {
            
            UserDefaultsUtils().setLogIn(status: true, role: .student)
            return (isLoggedIn: true, role: .student, error: nil)
            
        } else if username.lowercased() == "lehrer" && hashedString == Constants.hashedPasswordLehrerString {
            
            UserDefaultsUtils().setLogIn(status: true, role: .teacher)
            return (isLoggedIn: true, role: .teacher, error: nil)
            
        }
        
        return (isLoggedIn: false, role: .student, error: LoginError.wrongCredentials)
        
    }
    
}
