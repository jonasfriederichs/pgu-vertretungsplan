//
//  PDFPlanView.swift
//  PDFPlanView
//
//  Created by Wolf Jonas Friederichs on 9/10/21.
//

import SwiftUI

struct FullPlanView: View {
    
    let role: Role
    
    @State var selectedView: Int = 1
    
    @State var images: [[Image?]] = [[]]
    
    @State var error: Error? = nil
    
    let options = [LocalizedStringKey("today"), LocalizedStringKey("tomorrow")]
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                HStack {
                    
                    if images != [[]] {
                        Picker("Tag", selection: $selectedView, content: {
                            ForEach(1...options.count, id: \.self) {
                                Text(options[$0-1])
                            }
                        })
                        .pickerStyle(.segmented)
                        .padding(20)
                    } else {
                        Spacer()
                    }
                    
                    Button {
                        error = nil
                        selectedView = 1
                        images = [[]]
                        updatePlans()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .padding()
                }
                
                if error != nil {
                    
                    ErrorView(error: error)
                    
                } else {
                    
                    PDFPlanView(images: images[selectedView-1])
                    
                }
                
            }
            .padding()
            
        }
        .onAppear {
            error = nil
            print("OnAppear PDFPlan called")
            updatePlans()
        }
        
    }
    
    func updatePlans() {
        
        Task {
            
            let networkResult = await NetworkingUtils.shared.getPDFImages(role: role)
            
            switch networkResult {
            case .success(let images):
                self.images = images
            case .failure(let error):
                self.error = error
            }
            
        }
        
    }
    
}


struct FullPlanView_Previews: PreviewProvider {
    static var previews: some View {
        FullPlanView(role: .student)
    }
}


struct ErrorView: View {
    
    var error: Error?
    
    var body: some View {
        
        Spacer()
        
        Text(error?.localizedDescription ?? "someError")
            .foregroundColor(.red)
            .padding()
        
        Spacer()
        
    }
    
}



struct PDFPlanView: View {
    
    var images: [Image?]
    
    @State var currentIndex = 0
    
    var body: some View {
        
        if images.count > 0 {
            
            PagerView(pageCount: images.count, currentIndex: $currentIndex) {
                
                ForEach(1...images.count, id: \.self) { urlCount in
                    
                    ImagePlanView(image: images[urlCount-1])
                    
                }
                
            }
            .padding(.bottom, 10)
        } else {
            
            Spacer()
            
            ProgressView()
            
            Spacer()
            
        }
        
    }
    
}




struct ImagePlanView: View {
    
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

