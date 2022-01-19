//
//  SubstitutionView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/30/21.
//

import SwiftUI

struct SubstitutionView: View {
    
    @State var substitutions: [[Vertretung]] = [[]]
    
    var body: some View {
        
        HStack {
            
            if !substitutions.isEmpty {
                
                ScrollView {
                    
                    ForEach(substitutions[0], id: \.self) { substitution in
                        
                        IndividualSubstitutionView(substitution: substitution)
                        
                    }
                    
                }
                
            }
                
        }
        .onAppear {
            Task {
                print("getting 2")
                substitutions = await SubstitutionUtils().getSubstitutions()
                print(substitutions)
            }
        }
        
    }
    
}

struct SubstitutionView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SubstitutionView()
            .previewInterfaceOrientation(.portrait)
        
    }
    
}


struct IndividualSubstitutionView: View {
    
    @State var substitution: Vertretung
    
    var body: some View {
        
        HStack {
            
            Text("\(substitution.stunde). Stunde")
                .fontWeight(.heavy)
            
            Spacer()
            
            VStack {
                
                // Type
                Text(substitution.art)
                    .padding(.top, 2.5)
                
                // Subject
                Text(substitution.kurs)
                    .padding(.top, 2.5)
                
                // Teacher
                Text(substitution.vertreter)
                    .padding(.top, 2.5)
                
                // Room
                Text(substitution.raum)
                    .padding(.top, 2.5)
                
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width-50, height: 150)
        .background(Color.secondary)
        .cornerRadius(20)
        .shadow(color: Color.secondary, radius: 10, x: 20, y: 20)
        
    }
    
}
