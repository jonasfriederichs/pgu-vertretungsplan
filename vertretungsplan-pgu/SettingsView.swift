//
//  SettingsView.swift
//  SettingsView
//
//  Created by Wolf Jonas Friederichs on 9/15/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var defaults: (isLoggedIn: Bool, role: Role)
    
    var body: some View {
        
        VStack {
        
            Spacer()
            
            Button("Sign Out") {
                
                defaults = (isLoggedIn: false, role: defaults.role)
                UserDefaultsUtils().setLogIn(status: false, role: defaults.role)
                
            }
            .font(.headline.bold())
            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(20)
            
            
            Spacer()
            
            Text(Constants.impressum)
                .padding()
                .foregroundColor(Color.secondary)
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
