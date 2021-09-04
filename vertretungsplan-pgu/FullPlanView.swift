//
//  FullPlanView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import SwiftUI

struct FullPlanView: View {
    var day: day
    
    @State var imageURL: URL? = nil
    
    var body: some View {
        
        PlanView(url: imageURL)
        .onAppear {
            getURL(day: day)
        }
        
    }
    
    
    
    
    func getURL(day: day) {
        async {
            do {
                let url = try await createImageURLs()
                
                switch day {
                case .today: imageURL = url[0][0]
                case .today1:
                    imageURL = url[0][0]
                case .today2:
                    imageURL = url[0][1]
                case .tomorrow:
                    imageURL = url[1][0]
                case .tomorrow1:
                    imageURL = url[1][0]
                case .tomorrow2:
                    imageURL = url[1][1]
                }
                
            } catch {
                print(error)
            }
        }
        
    }
    
}

struct FullPlanView_Previews: PreviewProvider {
    static var previews: some View {
        FullPlanView(day: .today)
    }
}



struct PlanView: View {
    
    var url: URL?
     
    var body: some View {
        
        AsyncImage(url: url) { phase in
            switch phase {
                
            case .empty:
                ZStack {
                    Color.purple.opacity(0.1)
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .gesture(MagnificationGesture(minimumScaleDelta: 0.1))
                
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
            
        }
        
    }
    
}

