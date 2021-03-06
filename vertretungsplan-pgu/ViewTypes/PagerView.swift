//
//  PagerView.swift
//  PagerView
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import SwiftUI

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
                        
                        if pageCount > 1 {
                            
                            ForEach(0..<self.pageCount, id: \.self) { index in
                                Circle()
                                    .fill(index == self.currentIndex ? Color.primary : Color.secondary)
                                    .frame(width: 5, height: 5)
                            }
                            
                        }
                        
                    }
                }
                .offset(y: 16)
            }
        }
    }
}
