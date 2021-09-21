//
//  LoginView.swift
//  LoginView
//
//  Created by Wolf Jonas Friederichs on 9/6/21.
//

import SwiftUI

struct LoginView: View {
    
    let utils = LoginUtils()
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var loggedIn: Bool
    
    @State var username = ""
    @State var password = ""
    
    @State var error: (Bool, LoginError?) = (false, nil)
    
    var body: some View {
        VStack {
            
            Spacer()

            Image("pgu-logo")
                .resizable()
                .scaledToFit()
                .if(colorScheme == .light) { $0.colorInvert() }
                .padding(30)
            
            Spacer()
            
            
            TextFields(email: $username, password: $password)
            
            Spacer()
            
            Text($error.1.wrappedValue?.localizedDescription ?? "No error")
                .foregroundColor(Color.red)
                .opacity($error.0.wrappedValue ? 1.0 : 0.0)
                .padding()
                
            
            Button("LOGIN") {
                let result = utils.loginButtonPressed(username: username, password: password)
                print(result)
                loggedIn = result.0
                if result.0 == false { error = (true, result.1) }
                print(error)
            }
            .disabled($username.wrappedValue == "" || $password.wrappedValue == "")
            .font(.headline.bold())
            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(20)
            
            Spacer()
            
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
            .preferredColorScheme(.dark)
    }
}
