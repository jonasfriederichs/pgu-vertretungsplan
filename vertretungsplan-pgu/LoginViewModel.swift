//
//  LoginViewModel.swift
//  LoginViewModel
//
//  Created by Wolf Jonas Friederichs on 9/6/21.
//

import Foundation
import CryptoKit


class LoginViewModel {
    
    let hashedPassword = Constants().hashedPasswordSchuelerString
    
    func loginButtonPressed(username: String, password: String) -> (Bool, LoginError?) {
        
        let hashedString = CryptoUtils().encryptWithSHA256(string: password)
        
        if username.lowercased() == "schueler" && hashedString == hashedPassword {
            
            UserDefaultsUtils().setLogIn(status: true)
            return (true, nil)
            
        } else {
            
            return (false, LoginError.wrongCredentials)
            
        }
        
    }
    
}
