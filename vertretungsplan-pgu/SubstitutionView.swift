//
//  SubstitutionView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/30/21.
//

import SwiftUI

struct SubstitutionView: View {
    
    var body: some View {
        
        IndividualSubstitutionView()
        
    }
    
}

struct SubstitutionView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SubstitutionView()
.previewInterfaceOrientation(.portrait)
        
    }
    
}


struct IndividualSubstitutionView: View {
    
    var body: some View {
        
        HStack {
            
            Text("5. Stunde")
                .fontWeight(.heavy)
            
            Spacer()
            
            VStack {
                
                Text("Raumvertretung")
                    .padding(.top, 2.5)
                
                Text("Mathematik")
                    .padding(.top, 2.5)
                
                Text("KAM -> VOGT")
                    .padding(.top, 2.5)
                
                Text("105 -> 205")
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
