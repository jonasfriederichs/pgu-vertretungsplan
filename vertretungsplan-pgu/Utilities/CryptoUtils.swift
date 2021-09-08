//
//  CryptoUtils.swift
//  CryptoUtils
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import Foundation
import CryptoKit

struct CryptoUtils {
    
    func encryptWithSHA256(string: String) -> String {
        
        let hashed = SHA256.hash(data: Data(string.utf8))
        let hashedString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashedString
        
    }
    
}
