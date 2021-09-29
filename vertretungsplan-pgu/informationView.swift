//
//  informationView.swift
//  informationView
//
//  Created by Wolf Jonas Friederichs on 9/26/21.
//

import SwiftUI

struct informationView: View {
    var body: some View {
        
        VStack {
            
            Spacer()
        
            Text(Constants.informationText)
                .multilineTextAlignment(.center)
                .padding()
        
            Spacer()
            
            Text(Constants.impressum)
                .foregroundColor(Color.secondary)
                .padding()
            
        }
        
    }
}

struct informationView_Previews: PreviewProvider {
    static var previews: some View {
        informationView()
    }
}
