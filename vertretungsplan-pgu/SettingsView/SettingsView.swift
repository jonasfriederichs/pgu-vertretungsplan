//
//  SettingsView.swift
//  SettingsView
//
//  Created by Wolf Jonas Friederichs on 9/15/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var defaults: (isLoggedIn: Bool, role: Role, className: String)
    @State var popover: Bool = false
    @State var classSelectorPopover: Bool = false
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Button {
                classSelectorPopover = true
            } label: {
                VStack {
                    Text("Current class:")
                        .font(.headline)
                        .padding(10)
                    
                    Text(defaults.className)
                        .font(.title2)
                    
                    Text("Tap to change")
                        .font(.subheadline)
                        .padding(5)
                }
            }
            .padding()
            .background(Color.accentColor.opacity(0.1))
            .cornerRadius(15)
            .popover(isPresented: $classSelectorPopover) {
                ClassPickerView(selectedClass: $defaults.className, presented: $classSelectorPopover)
            }
            
            Spacer()
            
            HStack {
                
                Image(systemName: "lock")
                
                Button(LocalizedStringKey("signout")) {
                    
                    defaults = (isLoggedIn: false, role: defaults.role, className: defaults.className)
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
        SettingsView(defaults: .constant((isLoggedIn: true, role: .student, className: "5a")))
    }
}



struct ClassPickerView: View {
    
    @Binding var selectedClass: String
    @Binding var presented: Bool
//    @Binding var defaults: (isLoggedIn: Bool, role: Role, className: String)
    
    private var columns: [GridItem] {
        let count = 3
        return Array(repeating: .init(.flexible()), count: count)
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Select your class")
                .font(.title)
            
            
            ForEach(5...10, id: \.self) { grade in
                
                HStack(spacing: 20) {
                    
                    ForEach(["a", "b", "c"], id: \.self) { subclass in
                        
                        Button {
                            updateClass(new: "\(grade)\(subclass)")
                        } label: {
                            Text("\(grade)\(subclass)")
                                .padding()
                                .frame(width: 90)
                                .background(Color.accentColor.opacity(selectedClass == "\(grade)\(subclass)" ? 0.4 : 0.1))
                                .cornerRadius(5)
                        }
                    }
                }
            }
            
            ForEach(["Q1", "Q2", "all"], id: \.self) { grade in
                
                Button {
                    updateClass(new: "\(grade)")
                } label: {
                    Text("\(grade)")
                        .padding()
                        .frame(width: 90)
                        .background(Color.accentColor.opacity(selectedClass == "\(grade)" ? 0.4 : 0.1))
                        .cornerRadius(5)
                }
                
            }
            
            
            
        }
    }
    
    func updateClass(new: String) {
        withAnimation {
            selectedClass = new
            presented = false
        }
        
        UserDefaultsUtils().setClassName(name: new)
    }
    
    
}



struct ImpressumView: View {
    
    var body: some View {
        
        Text(Constants.impressum)
        
    }
    
}
