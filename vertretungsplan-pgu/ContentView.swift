//
//  ContentView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var defaults = UserDefaultsUtils().getDefaults() {
        didSet { print(self) } }
    
    var body: some View {
        
        if defaults.isLoggedIn == false {
            
            LoginView(defaults: $defaults)
            
        } else {
            
            TabView {
                
                PDFPlanViews(role: defaults.role)
                    .tabItem {
                        Image(systemName: "doc.plaintext")
                        Text(LocalizedStringKey("plan"))
                    }
                
//                Webview(url: URL(string: "https://www.pgu.de/aktuelles/termine")!)
//                    .tabItem {
//                        Image(systemName: "safari")
//                        Text("Termine")
//                    }
                
                SettingsView(defaults: $defaults)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text(LocalizedStringKey("settings"))
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
