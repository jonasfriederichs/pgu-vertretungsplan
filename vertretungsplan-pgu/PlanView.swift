//
//  FullPlanView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import SwiftUI


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
                    .gesture(MagnificationGesture().onChanged { val in
                                let delta = val / self.lastScaleValue
                                self.lastScaleValue = val
                                let newScale = image.scale * delta

                    //... anything else e.g. clamping the newScale
                    }.onEnded { val in
                      // without this the next gesture will be broken
                      self.lastScaleValue = 1.0
                    })
                    
                
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
            
        }
        
    }
    
}


struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    self.content.frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                .offset(x: self.translation)
                .animation(.interactiveSpring(), value: 1)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
                )
                
                VStack {
                    Spacer()
                    
                    HStack {
                        ForEach(0..<self.pageCount, id: \.self) { index in
                            Circle()
                                .fill(index == self.currentIndex ? Color.white : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                    }
                }
                .offset(y: 16)
            }
        }
    }
}

