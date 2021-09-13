//
//  ContentView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var defaults = UserDefaultsUtils().getDefaults()
    
    var body: some View {
        
        if defaults.isLoggedIn == false {
            
            LoginView(loggedIn: $defaults.isLoggedIn)
            
        } else {
            
            TabView {
                
                PDFPlanViews(role: defaults.role)
                    .tabItem {
                        Image(systemName: "doc.plaintext")
                        Text("Schüler")
                    }
                
                LogOutView(loggedIn: $defaults.isLoggedIn)
                    .tabItem {
                        Image(systemName: "trash")
                        Text("LogOut")
                    }
                
                Webview(url: URL(string: "https://www.pgu.de/aktuelles/termine")!)
                    .tabItem {
                        Image(systemName: "safari")
                        Text("Termine")
                    }
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
