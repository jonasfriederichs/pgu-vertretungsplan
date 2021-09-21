//
//  LoginUtils.swift
//  LoginUtils
//
//  Created by Wolf Jonas Friederichs on 9/15/21.
//

import Foundation
import CryptoKit


class LoginUtils {
    
    func loginButtonPressed(username: String, password: String) -> (Bool, LoginError?) {
        
        let hashedString = CryptoUtils().encryptWithSHA256(string: password)
        
        if username.lowercased() == "schueler" && hashedString == Constants.hashedPasswordSchuelerString {
            
            UserDefaultsUtils().setLogIn(status: true, role: .student)
            return (true, nil)
            
        } else if username.lowercased() == "lehrer" && hashedString == Constants.hashedPasswordLehrerString {
            
            UserDefaultsUtils().setLogIn(status: true, role: .teacher)
            return (true, nil)
            
        }
        
        return (false, LoginError.wrongCredentials)
        
    }
    
}
