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
    
    func loginButtonPressed(username: String, password: String) -> Bool {
        
        let hashed = SHA256.hash(data: Data(password.utf8))
        let hashedString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        if username.lowercased() == "schueler" && hashedString == hashedPassword {
            
            return true
            
        } else {
            
            return false
            
        }
        
    }
    
}
