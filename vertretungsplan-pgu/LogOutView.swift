//
//  LogOutView.swift
//  LogOutView
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import SwiftUI

struct LogOutView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        Button("Sign Out") {
            loggedIn = false
            UserDefaults.standard.set(false, forKey: "loggedIn")
        }
    }
}
