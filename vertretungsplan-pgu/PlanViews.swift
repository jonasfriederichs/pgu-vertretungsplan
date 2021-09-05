//
//  PlanViews.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/5/21.
//

import SwiftUI

struct PlanViews: View {
    
    @State var selectedView: Int = 1
    @State var urls: [[URL?]] = [[]]
    let options = ["Heute", "Morgen"]
    
    var body: some View {
        
        VStack {
            
            Picker("Tag", selection: $selectedView, content: {
                ForEach(1...urls.count, id: \.self) {
                    Text(options[$0-1])
                }
            })
                .pickerStyle(.segmented)
            
            PlanView(url: urls[selectedView-1])
            
        }
        .padding()
        // When appearing get image URLs
        .onAppear { async { do { urls = try await createImageURLs() } catch { print(error) } } }
        
    }
    
}

struct PlanViews_Previews: PreviewProvider {
    static var previews: some View {
        PlanViews()
    }
}





