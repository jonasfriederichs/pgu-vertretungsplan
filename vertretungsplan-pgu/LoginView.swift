//
//  LoginView.swift
//  LoginView
//
//  Created by Wolf Jonas Friederichs on 9/6/21.
//

import SwiftUI

struct LoginView: View {
    
    let viewModel = LoginViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var loggedIn: Bool
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            
            Spacer()

            Image("pgu-logo")
                .resizable()
                .scaledToFit()
                .if(colorScheme == .light) { $0.colorInvert() }
            
            Spacer()
            
            
            TextFields(email: $username, password: $password)
            
            Spacer()
            
            Button("LOGIN") {
                let result = viewModel.loginButtonPressed(username: username, password: password)
                loggedIn = result
            }
            .font(.headline.bold())
            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(20)
            
        }
        
    }
    
}


struct TextFields: View {
    
    @Binding var email: String
    
    @Binding var password: String
    
    var body: some View {
        VStack {
            
            // email text field
            
            HStack {
                
                Image(systemName: "person")
                    .frame(width: 35)
                
                TextField("USERNAME", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white.opacity(email == "" ? 0 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
            }
            .padding()
            
            // password text field
            
            HStack {
                
                Image(systemName: "lock")
                    .frame(width: 35)
                
                SecureField("PASSWORD", text: $password)
                    .padding()
                    .background(Color.white.opacity(password == "" ? 0 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
            }
            .padding()
            
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loggedIn: .constant(false))
    }
}
