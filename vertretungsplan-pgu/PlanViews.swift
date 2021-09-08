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
                    .padding(.top)
                
                PlanView(url: urls[selectedView-1])
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            // When appearing get image URLs
            .onAppear { Task { do { urls = try await ImageURLUtils().createImageURLs() } catch { print(error) } } }
            
        
        
    }
    
}

struct PlanViews_Previews: PreviewProvider {
    static var previews: some View {
        PlanViews()
    }
}




struct PlanView: View {
    
    var url: [URL?]
    
    @State var currentIndex = 0
    
    var body: some View {
        
        if url.count > 0 {
            
            PagerView(pageCount: url.count, currentIndex: $currentIndex) {
                
                ForEach(1...url.count, id: \.self) { urlCount in
                    
                    ImagePlanView(url: url[urlCount-1])
                    
                }
                
            }
        } else {
            
            Spacer()
            
            ProgressView()
            
            Spacer()
            
        }
        
    }
    
}


struct ImagePlanView: View {
    
    var url: URL?
    
    @State var lastScaleValue: CGFloat = 1.0
    
    var body: some View {
        
        ZoomableScrollView {
            
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
                    
                    
                case .failure(_):
                    Image(systemName: "exclamationmark.icloud")
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                }
                
            }
            
        }
        
    }
    
}



