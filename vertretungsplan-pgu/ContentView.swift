//
//  ContentView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    
    var body: some View {
        
        if loggedIn == false {
            
            LoginView(loggedIn: $loggedIn)
            
        } else {
            
            TabView {
                
                PlanViews()
                    .tabItem {
                        Image(systemName: "doc")
                        Text("Vertretungspläne")
                    }
                
                PDFPlanViews(role: .teacher)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Lehrer")
                    }
                
                LogOutView(loggedIn: $loggedIn)
                    .tabItem {
                        Image(systemName: "trash")
                        Text("LogOut")
                    }
                
                Webview(url: URL(string: "https://www.pgu.de/aktuelles/termine")!)
                    .tabItem {
                        Image(systemName: "safari")
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
