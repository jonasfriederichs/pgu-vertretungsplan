//
//  SettingsView.swift
//  SettingsView
//
//  Created by Wolf Jonas Friederichs on 9/15/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var defaults: (isLoggedIn: Bool, role: Role)
    @State var popover: Bool = false
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                
                Image(systemName: "lock")
                
                Button(LocalizedStringKey("signout")) {
                    
                    defaults = (isLoggedIn: false, role: defaults.role)
                    UserDefaultsUtils().setLogIn(status: false, role: defaults.role)
                    
                }
                .font(.headline.bold())
                
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
            .background(Color.accentColor)
            .foregroundColor(Color.white)
            .cornerRadius(20)
            
            Spacer()
            
            Button("Information") {
                popover = true
            }
            .popover(isPresented: $popover) {
                informationView()
            }
            .padding()
            
        }
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(defaults: .constant((isLoggedIn: true, role: .student)))
    }
}



struct ImpressumView: View {
    
    var body: some View {
        
        Text(Constants.impressum)
        
    }
    
}
