//
//  PDFPlanView.swift
//  PDFPlanView
//
//  Created by Wolf Jonas Friederichs on 9/10/21.
//

import SwiftUI

struct PDFPlanViews: View {
    
    let role: Role
    
    @State var selectedView: Int = 1
    
    @State var images: [[Image?]] = [[]]
    
    let options = ["Heute", "Morgen"]
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Picker("Tag", selection: $selectedView, content: {
                    ForEach(1...options.count, id: \.self) {
                        Text(options[$0-1])
                    }
                })
                    .pickerStyle(.segmented)
                    .padding(20)
                
                Button {
                    selectedView = 1
                    images = [[]]
                    Task { do { images = try await NetworkingUtils().getPDFImages(role: role) } catch { print(error) } }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .padding()

                
            }
            
            PDFPlanView(images: images[selectedView-1])
            
        }
        .padding()
        // When appearing get images
        .onAppear {
            
            print("OnAppear PDFPlan called")
            Task { do { images = try await NetworkingUtils().getPDFImages(role: role) } catch { print(error) }
                
            }
            
            
            
        }
        
    }
    
}



struct PDFPlanView: View {
    
    var images: [Image?]
    
    @State var currentIndex = 0
    
    var body: some View {
        
        if images.count > 0 {
            
            PagerView(pageCount: images.count, currentIndex: $currentIndex) {
                
                ForEach(1...images.count, id: \.self) { urlCount in
                    
                    ImagePlanView2(image: images[urlCount-1])
                    
                }
                
            }
        } else {
            
            Spacer()
            
            ProgressView()
            
            Spacer()
            
        }
        
    }
    
}




struct ImagePlanView2: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var image: Image?
    
    var body: some View {
        
        ZoomableScrollView {
            
            if image == nil {
                
                ProgressView()
                
            } else {
                
                image!
                    .resizable()
                    .scaledToFit()
                    .if(colorScheme == .dark) { $0.colorInvert() }
                
            }
            
        }
        
    }
    
}

